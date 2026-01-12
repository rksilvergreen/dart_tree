// GENERATED CODE - DO NOT MODIFY BY HAND
// Generated from blog_post_schema.dart

import 'package:dart_tree/dart_tree.dart';

/// Generated TreeNode class for User
class UserNode extends CollectionNode {
  UserNode({super.id});

  StringValueNode get name => $children!['name'] as StringValueNode;
  StringValueNode get email => $children!['email'] as StringValueNode;

  set name(String value) {
    if (value.length < 1 || value.length > 100) {throw ArgumentError('name must be 1-100 characters');}
    final tree = $tree;
    if (tree != null) {
      final oldNode = name;
      final newNode = StringValueNode(value);
      final newSubtree = Tree(root: newNode);
      tree.replaceSubtree(node: oldNode, newSubtree: newSubtree);
    }
  }

  set email(String value) {
    if (value.length < 1 || value.length > 100) {throw ArgumentError('email must be 1-100 characters');}
    final tree = $tree;
    if (tree != null) {
      final oldNode = email;
      final newNode = StringValueNode(value);
      final newSubtree = Tree(root: newNode);
      tree.replaceSubtree(node: oldNode, newSubtree: newSubtree);
    }
  }


  @override
  UserNode clone() => UserNode(id: id);
}
