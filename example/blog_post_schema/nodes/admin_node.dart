// GENERATED CODE - DO NOT MODIFY BY HAND
// Generated from blog_post_schema.dart

import 'package:dart_tree/dart_tree.dart';

/// Generated TreeNode class for Admin
class AdminNode extends CollectionNode {
  AdminNode({super.id});

  IntValueNode get age => $children!['age'] as IntValueNode;
  StringValueNode get address => $children!['address'] as StringValueNode;

  set age(int value) {
    if (value < 18.0) {throw ArgumentError('age must be >= 18.0');}
    final tree = $tree;
    if (tree != null) {
      final oldNode = age;
      final newNode = IntValueNode(value);
      final newSubtree = Tree(root: newNode);
      tree.replaceSubtree(node: oldNode, newSubtree: newSubtree);
    }
  }

  set address(String value) {
    if (value.length < 1 || value.length > 100) {throw ArgumentError('address must be 1-100 characters');}
    final tree = $tree;
    if (tree != null) {
      final oldNode = address;
      final newNode = StringValueNode(value);
      final newSubtree = Tree(root: newNode);
      tree.replaceSubtree(node: oldNode, newSubtree: newSubtree);
    }
  }


  @override
  AdminNode clone() => AdminNode(id: id);
}
