// import '../nodes/tree_node.dart';
// import '../tree.dart';

// /// Strategy for tree traversal order.
// enum TraversalOrder {
//   /// Visit parent before children (pre-order).
//   preOrder,

//   /// Visit children before parent (post-order).
//   postOrder,

//   /// Visit level by level (breadth-first).
//   breadthFirst,
// }

// /// Callback function for tree traversal.
// typedef TraversalCallback = void Function(TreeNode node, int depth, String path);

// /// Callback function that can control traversal flow.
// typedef TraversalCallbackWithControl = TraversalAction Function(
//     TreeNode node, int depth, String path);

// /// Actions that can be returned from a traversal callback to control flow.
// enum TraversalAction {
//   /// Continue traversal normally.
//   continue_,

//   /// Skip children of this node, but continue with siblings.
//   skipChildren,

//   /// Stop traversal completely.
//   stop,
// }

// /// Extension providing traversal operations on Tree.
// extension TreeTraversal on Tree {
//   /// Traverses the tree with the given callback.
//   /// 
//   /// The callback receives the node, its depth (0 for root), and its path.
//   void traverse(
//     TraversalCallback callback, {
//     TraversalOrder order = TraversalOrder.preOrder,
//   }) {
//     final rootNode = root;
//     if (rootNode == null) return;

//     switch (order) {
//       case TraversalOrder.preOrder:
//         _traversePreOrder(rootNode, 0, '/', callback);
//         break;
//       case TraversalOrder.postOrder:
//         _traversePostOrder(rootNode, 0, '/', callback);
//         break;
//       case TraversalOrder.breadthFirst:
//         _traverseBreadthFirst(callback);
//         break;
//     }
//   }

//   /// Traverses with control flow options.
//   void traverseWithControl(
//     TraversalCallbackWithControl callback, {
//     TraversalOrder order = TraversalOrder.preOrder,
//   }) {
//     final rootNode = root;
//     if (rootNode == null) return;

//     switch (order) {
//       case TraversalOrder.preOrder:
//         _traversePreOrderWithControl(rootNode, 0, '/', callback);
//         break;
//       case TraversalOrder.postOrder:
//         _traversePostOrderWithControl(rootNode, 0, '/', callback);
//         break;
//       case TraversalOrder.breadthFirst:
//         _traverseBreadthFirstWithControl(callback);
//         break;
//     }
//   }

//   void _traversePreOrder(
//     TreeNode node,
//     int depth,
//     String path,
//     TraversalCallback callback,
//   ) {
//     callback(node, depth, path);

//     final children = getChildren(node);
//     if (children != null) {
//       for (final entry in children.entries) {
//         final childPath = path == '/' ? '/${entry.key}' : '$path/${entry.key}';
//         _traversePreOrder(entry.value, depth + 1, childPath, callback);
//       }
//     }
//   }

//   TraversalAction _traversePreOrderWithControl(
//     TreeNode node,
//     int depth,
//     String path,
//     TraversalCallbackWithControl callback,
//   ) {
//     final action = callback(node, depth, path);
//     if (action == TraversalAction.stop) {
//       return TraversalAction.stop;
//     }
//     if (action == TraversalAction.skipChildren) {
//       return TraversalAction.continue_;
//     }

//     final children = getChildren(node);
//     if (children != null) {
//       for (final entry in children.entries) {
//         final childPath = path == '/' ? '/${entry.key}' : '$path/${entry.key}';
//         final childAction = _traversePreOrderWithControl(
//             entry.value, depth + 1, childPath, callback);
//         if (childAction == TraversalAction.stop) {
//           return TraversalAction.stop;
//         }
//       }
//     }

//     return TraversalAction.continue_;
//   }

//   void _traversePostOrder(
//     TreeNode node,
//     int depth,
//     String path,
//     TraversalCallback callback,
//   ) {
//     final children = getChildren(node);
//     if (children != null) {
//       for (final entry in children.entries) {
//         final childPath = path == '/' ? '/${entry.key}' : '$path/${entry.key}';
//         _traversePostOrder(entry.value, depth + 1, childPath, callback);
//       }
//     }

//     callback(node, depth, path);
//   }

//   TraversalAction _traversePostOrderWithControl(
//     TreeNode node,
//     int depth,
//     String path,
//     TraversalCallbackWithControl callback,
//   ) {
//     final children = getChildren(node);
//     if (children != null) {
//       for (final entry in children.entries) {
//         final childPath = path == '/' ? '/${entry.key}' : '$path/${entry.key}';
//         final childAction = _traversePostOrderWithControl(
//             entry.value, depth + 1, childPath, callback);
//         if (childAction == TraversalAction.stop) {
//           return TraversalAction.stop;
//         }
//       }
//     }

//     return callback(node, depth, path);
//   }

//   void _traverseBreadthFirst(TraversalCallback callback) {
//     final rootNode = root;
//     if (rootNode == null) return;

//     final queue = <(TreeNode, int, String)>[(rootNode, 0, '/')];

//     while (queue.isNotEmpty) {
//       final (node, depth, path) = queue.removeAt(0);
//       callback(node, depth, path);

//       final children = getChildren(node);
//       if (children != null) {
//         for (final entry in children.entries) {
//           final childPath =
//               path == '/' ? '/${entry.key}' : '$path/${entry.key}';
//           queue.add((entry.value, depth + 1, childPath));
//         }
//       }
//     }
//   }

//   void _traverseBreadthFirstWithControl(TraversalCallbackWithControl callback) {
//     final rootNode = root;
//     if (rootNode == null) return;

//     final queue = <(TreeNode, int, String)>[(rootNode, 0, '/')];

//     while (queue.isNotEmpty) {
//       final (node, depth, path) = queue.removeAt(0);
//       final action = callback(node, depth, path);

//       if (action == TraversalAction.stop) {
//         return;
//       }

//       if (action != TraversalAction.skipChildren) {
//         final children = getChildren(node);
//         if (children != null) {
//           for (final entry in children.entries) {
//             final childPath =
//                 path == '/' ? '/${entry.key}' : '$path/${entry.key}';
//             queue.add((entry.value, depth + 1, childPath));
//           }
//         }
//       }
//     }
//   }

//   /// Finds all nodes matching a predicate.
//   List<TreeNode> findAll(bool Function(TreeNode node) predicate) {
//     final results = <TreeNode>[];
//     traverse((node, depth, path) {
//       if (predicate(node)) {
//         results.add(node);
//       }
//     });
//     return results;
//   }

//   /// Finds the first node matching a predicate.
//   TreeNode? findFirst(bool Function(TreeNode node) predicate) {
//     TreeNode? result;
//     traverseWithControl((node, depth, path) {
//       if (predicate(node)) {
//         result = node;
//         return TraversalAction.stop;
//       }
//       return TraversalAction.continue_;
//     });
//     return result;
//   }
// }

