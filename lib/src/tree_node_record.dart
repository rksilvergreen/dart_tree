import 'nodes/tree_node.dart';
import 'edge.dart';

/// Internal record tracking a node's position and relationships within a tree.
///
/// This class is used by the Tree class to manage the node graph structure.
class TreeNodeRecord {
  /// The actual tree node.
  final TreeNode node;

  /// The JSON Pointer path to this node within the tree.
  String pointer;

  /// The ID of the parent node, or null if this is the root.
  String? parent;

  /// Map of edges to child node IDs.
  final Map<Edge, String> children = {};

  TreeNodeRecord({required this.node, required this.pointer, this.parent});

  @override
  String toString() => 'TreeNodeRecord(pointer: $pointer, parent: $parent, children: ${children.length})';
}
