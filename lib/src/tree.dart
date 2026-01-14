import 'dart:collection';
import 'package:uuid/uuid.dart';
import 'nodes/tree_node.dart';
import 'edge.dart';
import 'tree_node_record.dart';
import 'utils/pointer.dart';
import 'syntax/comment.dart';
import 'package:meta/meta.dart';
import 'objects/tree_object.dart';

const _uuid = Uuid();

/// Base class for all tree containers.
///
/// Users should create a concrete class extending Tree and annotate it with @GenerateTree().
/// The code generator will create an extension on your class with the objectToNode implementation.
///
/// Example:
/// ```dart
/// @GenerateTree()
/// class MyDomainTree extends Tree {
///   MyDomainTree({required super.root});
/// }
///
/// // Generated extension:
/// extension MyDomainTreeExtension on MyDomainTree {
///   @override
///   (TreeNode, List<(Edge, Object)>)? objectToNode(Object object) {
///     if (object is StringValue) {
///       return (StringValueNode(object), []);
///     }
///     // ... conversion logic for all @treeObject classes
///   }
/// }
/// ```
///
/// Note: While Tree is not abstract, you must extend it and implement objectToNode
/// (via code generation) for it to work correctly with your domain objects.
class Tree {
  /// Unique identifier for this tree.
  String id;

  /// Internal registry mapping node IDs to their records.
  final Map<String, TreeNodeRecord> _nodes = {};

  /// Registry of comments indexed by node ID.
  /// Each node can have multiple comments associated with it.
  final Map<String, List<Comment>> _comments = {};

  /// YAML anchor registry: anchor name -> node ID.
  /// Only populated for YAML trees that use anchors.
  final Map<String, String> _anchors = {};

  /// YAML alias references: node ID -> anchor name.
  /// Only populated for YAML trees that use aliases.
  final Map<String, String> _aliases = {};

  /// Creates a new tree with the given root object.
  ///
  /// The root can be either a TreeObject (which will be converted to a TreeNode)
  /// or a TreeNode directly. The tree will recursively process the root and all
  /// its children, assigning paths and establishing parent-child relationships.
  Tree({String? id, required TreeObject root}) : id = id ?? _uuid.v4() {
    // _createNode(pointer: '/', object: root);
    fromObject(root);
  }

  /// Creates a tree from an existing node registry (internal use).
  Tree._internal({required this.id, required Map<String, TreeNodeRecord> nodes}) {
    _nodes.addAll(nodes);
    for (final record in _nodes.values) {
      record.node.$tree = this;
    }
  }

  /// Gets the root node of this tree, or null if the tree is empty.
  TreeNode? get root {
    final record = _nodes.values.cast<TreeNodeRecord?>().firstWhere((r) => r!.pointer == '/', orElse: () => null);
    return record?.node;
  }

  /// Gets an unmodifiable view of the node registry.
  UnmodifiableMapView<String, TreeNodeRecord> get nodes => UnmodifiableMapView(_nodes);

  /// Gets a node by its ID.
  TreeNode? getNodeById(String id) => _nodes[id]?.node;

  /// Gets a node by its JSON Pointer path.
  TreeNode? getNodeByPath(String pointer) {
    final record = _nodes.values.cast<TreeNodeRecord?>().firstWhere((r) => r!.pointer == pointer, orElse: () => null);
    return record?.node;
  }

  /// Gets the path (JSON Pointer) for a node.
  String? getNodePath(TreeNode node) => _nodes[node.id]?.pointer;

  /// Gets the parent of a node.
  TreeNode? getParent(TreeNode node) {
    final parentId = _nodes[node.id]?.parent;
    return parentId != null ? _nodes[parentId]?.node : null;
  }

  /// Gets the children of a node as a map of keys to nodes.
  Map<String, TreeNode>? getChildren(TreeNode node) {
    final record = _nodes[node.id];
    if (record == null) return null;

    return Map.fromEntries(record.children.entries.map((e) => MapEntry(e.key.key, _nodes[e.value]!.node)));
  }

  /// Gets a specific child of a node by key.
  TreeNode? getChild(TreeNode node, String key) {
    final record = _nodes[node.id];
    if (record == null) return null;

    final edge = record.children.keys.cast<Edge?>().firstWhere((e) => e!.key == key, orElse: () => null);
    if (edge == null) return null;

    final childId = record.children[edge];
    return childId != null ? _nodes[childId]?.node : null;
  }

  // Comment management

  /// Get comments for a specific node.
  List<Comment> getComments(String nodeId) => _comments[nodeId] ?? [];

  /// Add a comment to a node.
  void addComment(String nodeId, Comment comment) {
    _comments.putIfAbsent(nodeId, () => []).add(comment);
  }

  /// Remove all comments from a node.
  void clearComments(String nodeId) {
    _comments.remove(nodeId);
  }

  /// Get all comments in the tree in document order (sorted by source position).
  List<CommentEntry> getAllComments() {
    final entries = <CommentEntry>[];
    for (final nodeId in _comments.keys) {
      for (final comment in _comments[nodeId]!) {
        entries.add(CommentEntry(nodeId: nodeId, comment: comment));
      }
    }
    // Sort by source position
    entries.sort((a, b) {
      final posA = a.position;
      final posB = b.position;
      if (posA.line != posB.line) return posA.line.compareTo(posB.line);
      if (posA.column != posB.column) return posA.column.compareTo(posB.column);
      return posA.offset.compareTo(posB.offset);
    });
    return entries;
  }

  // YAML anchor/alias management

  /// Register an anchor for a node (YAML-specific).
  ///
  /// Anchors allow nodes to be referenced by name for later reuse via aliases.
  @protected
  void registerAnchor(String anchorName, String nodeId) {
    _anchors[anchorName] = nodeId;
  }

  /// Register an alias reference (YAML-specific).
  ///
  /// Aliases reference previously defined anchors.
  void registerAlias(String nodeId, String anchorName) {
    _aliases[nodeId] = anchorName;
  }

  /// Get the node ID for an anchor name.
  String? resolveAnchor(String anchorName) => _anchors[anchorName];

  /// Check if a node is an anchor and get its name.
  String? getAnchorName(String nodeId) {
    return _anchors.entries.firstWhere((e) => e.value == nodeId, orElse: () => MapEntry('', '')).key;
  }

  /// Check if a node is an alias and get the anchor name it references.
  String? getAliasTarget(String nodeId) => _aliases[nodeId];

  /// Get all anchors defined in the tree.
  Map<String, String> get anchors => Map.unmodifiable(_anchors);

  /// Get all aliases defined in the tree.
  Map<String, String> get aliases => Map.unmodifiable(_aliases);

  // /// Converts a TreeObject to a TreeNode with its child edges.
  // ///
  // /// This method must be overridden by extensions (via code generation)
  // /// to handle conversion of domain-specific objects to tree nodes.
  // ///
  // /// Returns a tuple of:
  // /// - The created TreeNode
  // /// - A list of (Edge, Object) tuples representing children to be processed
  // ///
  // /// Returns null if the object type is not recognized.
  // ///
  // /// Default implementation returns null. The generated extension will override this.
  // (TreeNode, List<(Edge, Object)>)? objectToNode(Object object) => null;

  void fromObject<T extends TreeObject>(TreeObject object) => null;

  // /// Creates a node from an object and attaches it to the tree.
  // TreeNodeRecord _createNode({required String pointer, required Object object}) {
  //   final Map<Edge, TreeNodeRecord> children = {};

  //   // Convert object to node
  //   final conversion = objectToNode(object);
  //   if (conversion == null) {
  //     throw StateError(
  //       'Unable to convert object of type ${object.runtimeType} to TreeNode. '
  //       'Ensure objectToNode() handles this type.',
  //     );
  //   }

  //   final (node, edges) = conversion;

  //   // Recursively create children
  //   for (final (edge, childObject) in edges) {
  //     children[edge] = _createNode(pointer: Pointer.build(pointer, edge.key), object: childObject);
  //   }

  //   // Set tree reference and register node
  //   node.$tree = this;
  //   _nodes[node.id] = TreeNodeRecord(node: node, pointer: pointer);

  //   // Link children
  //   for (final child in children.entries) {
  //     _nodes[node.id]!.children[child.key] = child.value.node.id;
  //     child.value.parent = node.id;
  //   }

  //   return _nodes[node.id]!;
  // }

  Map<String, TreeNodeRecord> get $nodes => _nodes;

  /// Removes a subtree starting at the given node.
  ///
  /// Returns a new Tree containing the removed subtree with the given node as root.
  Tree removeSubtree(TreeNode node) {
    final record = _nodes[node.id];
    if (record == null) {
      throw StateError('Node ${node.id} is not part of this tree');
    }

    // Collect all nodes in the subtree
    final subtreeNodes = _collectSubtree(node, '/');

    // Remove from parent's children
    if (record.parent != null) {
      final parentRecord = _nodes[record.parent];
      if (parentRecord != null) {
        parentRecord.children.removeWhere((edge, childId) => childId == node.id);
      }
    }

    // Remove all subtree nodes from this tree
    for (final id in subtreeNodes.keys) {
      _nodes.remove(id);
    }

    // Create new tree with the subtree
    return Tree._internal(id: _uuid.v4(), nodes: subtreeNodes);
  }

  /// Collects all nodes in a subtree, updating their pointers relative to newRoot.
  Map<String, TreeNodeRecord> _collectSubtree(TreeNode node, String newRoot) {
    final result = <String, TreeNodeRecord>{};
    final record = _nodes[node.id];
    if (record == null) return result;

    // Update the record with new pointer
    final newRecord = TreeNodeRecord(node: record.node, pointer: newRoot, parent: null);
    newRecord.children.addAll(record.children);
    result[node.id] = newRecord;

    // Recursively collect children
    for (final entry in record.children.entries) {
      final childId = entry.value;
      final childNode = _nodes[childId]?.node;
      if (childNode != null) {
        final childKey = entry.key.key;
        final childPointer = Pointer.build(newRoot, childKey);
        final childSubtree = _collectSubtree(childNode, childPointer);
        result.addAll(childSubtree);

        // Update parent reference
        if (result[childId] != null) {
          result[childId]!.parent = node.id;
        }
      }
    }

    return result;
  }

  /// Replaces the root of this tree with a new subtree.
  ///
  /// Returns the old tree if there was a root, or null otherwise.
  Tree? replaceTree(Tree newTree) {
    Tree? oldTree;
    final currentRoot = root;

    if (currentRoot != null) {
      oldTree = removeSubtree(currentRoot);
    }

    final newRoot = newTree.root;
    if (newRoot == null) {
      throw StateError('New tree has no root');
    }

    // Transfer all nodes from newTree to this tree
    final transferredNodes = newTree._collectSubtree(newRoot, '/');
    for (final record in transferredNodes.values) {
      record.node.$tree = this;
      _nodes[record.node.id] = record;
    }

    // Clear the new tree
    newTree._nodes.clear();

    return oldTree;
  }

  /// Adds a subtree at the specified location.
  ///
  /// Returns the old subtree if there was one at that location, or null otherwise.
  Tree? addSubtree({required TreeNode parent, required String key, required Tree subtree}) {
    final parentRecord = _nodes[parent.id];
    if (parentRecord == null) {
      throw StateError('Parent node ${parent.id} is not part of this tree');
    }

    final subtreeRoot = subtree.root;
    if (subtreeRoot == null) {
      throw StateError('Subtree has no root');
    }

    // Check if there's already a child at this key
    Tree? oldTree;
    final existingEdge = parentRecord.children.keys.cast<Edge?>().firstWhere((e) => e!.key == key, orElse: () => null);

    if (existingEdge != null) {
      final existingChildId = parentRecord.children[existingEdge];
      if (existingChildId != null) {
        final existingChild = _nodes[existingChildId]?.node;
        if (existingChild != null) {
          oldTree = removeSubtree(existingChild);
        }
      }
    }

    // Calculate the new pointer for the subtree root
    final newPointer = Pointer.build(parentRecord.pointer, key);

    // Transfer subtree nodes
    final transferredNodes = subtree._collectSubtree(subtreeRoot, newPointer);
    for (final record in transferredNodes.values) {
      record.node.$tree = this;
      _nodes[record.node.id] = record;
    }

    // Update root's parent
    transferredNodes[subtreeRoot.id]!.parent = parent.id;

    // Add edge from parent to subtree root
    final edge = Edge(subtreeRoot.runtimeType, key);
    parentRecord.children[edge] = subtreeRoot.id;

    // Clear the subtree
    subtree._nodes.clear();

    return oldTree;
  }

  /// Replaces a subtree at the specified node.
  ///
  /// Returns the old subtree.
  Tree replaceSubtree({required TreeNode node, required Tree newSubtree}) {
    final record = _nodes[node.id];
    if (record == null) {
      throw StateError('Node ${node.id} is not part of this tree');
    }

    final newRoot = newSubtree.root;
    if (newRoot == null) {
      throw StateError('New subtree has no root');
    }

    if (node.runtimeType != newRoot.runtimeType) {
      throw StateError('Cannot replace ${node.runtimeType} with ${newRoot.runtimeType}');
    }

    // Remove the old subtree
    final oldTree = removeSubtree(node);

    // Add the new subtree in its place
    final parentId = record.parent;
    if (parentId != null) {
      final parent = _nodes[parentId]?.node;
      if (parent != null) {
        // Find the key that was used
        final parentRecord = _nodes[parentId]!;
        final edge = parentRecord.children.entries.cast<MapEntry<Edge, String>?>().firstWhere(
          (e) => e!.value == node.id,
          orElse: () => null,
        );

        if (edge != null) {
          addSubtree(parent: parent, key: edge.key.key, subtree: newSubtree);
        }
      }
    } else {
      // Replacing the root
      replaceTree(newSubtree);
    }

    return oldTree;
  }

  /// Creates a deep copy of this tree.
  Tree clone() {
    final clonedNodes = <String, TreeNodeRecord>{};

    for (final entry in _nodes.entries) {
      final record = entry.value;
      final clonedNode = record.node.clone();

      final clonedRecord = TreeNodeRecord(node: clonedNode, pointer: record.pointer, parent: record.parent);
      clonedRecord.children.addAll(record.children);

      clonedNodes[clonedNode.id] = clonedRecord;
    }

    return Tree._internal(id: _uuid.v4(), nodes: clonedNodes);
  }

  @override
  String toString() => 'Tree(id: $id, nodes: ${_nodes.length})';
}
