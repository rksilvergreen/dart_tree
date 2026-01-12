// import '../nodes/tree_node.dart';
// import '../tree.dart';
// import '../utils/pointer.dart';

// /// Extension providing query operations on Tree.
// extension TreeQuery on Tree {
//   /// Gets a node at the specified JSON Pointer path.
//   /// 
//   /// Returns null if the path doesn't exist.
//   /// 
//   /// Examples:
//   /// - `query('/')` returns the root
//   /// - `query('/users/0/name')` navigates through the path
//   TreeNode? query(String pointer) {
//     return getNodeByPath(pointer);
//   }

//   /// Gets a node at the specified path, throwing if it doesn't exist.
//   TreeNode queryOrThrow(String pointer) {
//     final node = query(pointer);
//     if (node == null) {
//       throw StateError('No node found at path: $pointer');
//     }
//     return node;
//   }

//   /// Queries using a list of segments instead of a pointer string.
//   TreeNode? querySegments(List<String> segments) {
//     final pointer = Pointer.build(segments);
//     return query(pointer);
//   }

//   /// Checks if a path exists in the tree.
//   bool exists(String pointer) {
//     return query(pointer) != null;
//   }

//   /// Gets the value from a ValueNode at the specified path.
//   /// 
//   /// Returns null if the path doesn't exist or the node is not a ValueNode.
//   T? getValue<T>(String pointer) {
//     final node = query(pointer);
//     if (node is ValueNode<T>) {
//       return node.value;
//     }
//     return null;
//   }

//   /// Gets a string value at the specified path.
//   String? getString(String pointer) {
//     final node = query(pointer);
//     if (node is StringNode) {
//       return node.value;
//     }
//     return null;
//   }

//   /// Gets an integer value at the specified path.
//   int? getInt(String pointer) {
//     final node = query(pointer);
//     if (node is IntNode) {
//       return node.value;
//     }
//     return null;
//   }

//   /// Gets a double value at the specified path.
//   double? getDouble(String pointer) {
//     final node = query(pointer);
//     if (node is DoubleNode) {
//       return node.value;
//     }
//     return null;
//   }

//   /// Gets a boolean value at the specified path.
//   bool? getBool(String pointer) {
//     final node = query(pointer);
//     if (node is BoolNode) {
//       return node.value;
//     }
//     return null;
//   }

//   /// Gets an ObjectNode at the specified path.
//   ObjectNode? getObject(String pointer) {
//     final node = query(pointer);
//     return node is ObjectNode ? node : null;
//   }

//   /// Gets an ArrayNode at the specified path.
//   ArrayNode? getArray(String pointer) {
//     final node = query(pointer);
//     return node is ArrayNode ? node : null;
//   }

//   /// Gets all child nodes of an object or array at the specified path.
//   List<TreeNode>? getChildNodes(String pointer) {
//     final node = query(pointer);
//     if (node == null) return null;

//     final children = getChildren(node);
//     return children?.values.toList();
//   }

//   /// Gets all child node paths under the specified path.
//   List<String> getChildPaths(String pointer) {
//     final node = query(pointer);
//     if (node == null) return [];

//     final children = getChildren(node);
//     if (children == null) return [];

//     return children.keys
//         .map((key) => pointer == '/' ? '/$key' : '$pointer/$key')
//         .toList();
//   }
// }

