import 'package:uuid/uuid.dart';
import '../syntax/source_position.dart';
import '../syntax/json_formatting.dart';
import '../syntax/yaml_formatting.dart';
import '../tree.dart';

const _uuid = Uuid();

/// Base class for all tree nodes.
///
/// Each node has a unique identifier, optional syntactic metadata,
/// and maintains references to its tree context.
abstract class TreeNode {
  /// Unique identifier for this node.
  final String id;

  /// The source range in the original file (if parsed).
  SourceRange? sourceRange;

  /// JSON-specific formatting information.
  ///
  /// Populated when parsing from JSON or when explicitly set for JSON serialization.
  JsonFormattingInfo? jsonFormatting;

  /// YAML-specific formatting information.
  ///
  /// Populated when parsing from YAML or when explicitly set for YAML serialization.
  YamlFormattingInfo? yamlFormatting;

  /// Reference to the tree this node belongs to.
  /// This is managed internally by the Tree class.
  Tree? _tree;

  /// Internal getter for tree reference (used by Tree class).
  Tree? get tree => _tree;

  /// Internal setter for tree reference (used by Tree class).
  set tree(Tree? value) => _tree = value;

  TreeNode({String? id, this.sourceRange, this.jsonFormatting, this.yamlFormatting}) : id = id ?? _uuid.v4();

  // Public accessors for generated code

  /// Public accessor for node ID (prefixed with $ to avoid naming conflicts).
  String get $id => id;

  /// Public accessor for tree reference (prefixed with $ to avoid naming conflicts).
  Tree? get $tree => _tree;

  /// Public accessor for parent node (prefixed with $ to avoid naming conflicts).
  TreeNode? get $parent {
    if (_tree == null) return null;
    final record = _tree!.nodes[id];
    if (record == null || record.parent == null) return null;
    return _tree!.nodes[record.parent]?.node;
  }

  /// Public accessor for children by key (prefixed with $ to avoid naming conflicts).
  Map<String, TreeNode>? get $children {
    if (_tree == null) return null;
    final record = _tree!.nodes[id];
    if (record == null) return null;

    final result = <String, TreeNode>{};
    for (final entry in record.children.entries) {
      final childId = entry.value;
      final childNode = _tree!.nodes[childId]?.node;
      if (childNode != null) {
        result[entry.key.key] = childNode;
      }
    }
    return result.isEmpty ? null : result;
  }

  /// The path to this node within its tree (JSON Pointer format).
  /// Returns null if the node is not part of a tree.
  String? get path {
    if (_tree == null) return null;
    // This will be implemented by Tree class
    throw UnimplementedError('Path retrieval requires Tree implementation');
  }

  /// Creates a deep copy of this node with a new ID.
  TreeNode clone();

  /// Accept a visitor for traversal operations.
  T accept<T>(TreeNodeVisitor<T> visitor) => visitor.visitNode(this);
}

/// Abstract base class for leaf nodes that hold a single value.
abstract class ValueNode<T> extends TreeNode {
  T get value;

  ValueNode({super.id, super.sourceRange, super.jsonFormatting, super.yamlFormatting});
}

/// Abstract base class for collection nodes (nodes with children).
abstract class CollectionNode extends TreeNode {
  CollectionNode({super.id, super.sourceRange, super.jsonFormatting, super.yamlFormatting});
}

/// Visitor interface for traversing tree nodes.
///
/// This is extensible - users can create their own visitors for custom nodes.
abstract class TreeNodeVisitor<T> {
  /// Default handler for any node type.
  T visitNode(TreeNode node);
}
