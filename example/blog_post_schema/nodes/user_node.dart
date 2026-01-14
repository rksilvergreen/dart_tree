// GENERATED CODE - DO NOT MODIFY BY HAND
// Generated from blog_post_schema.dart

import 'package:dart_tree/dart_tree.dart';

/// Generated TreeNode class for User
class UserNode extends CollectionNode {
  UserNode({super.id});

  StringValueNode get name => this.$children!['name'] as StringValueNode;
  StringValueNode get email => this.$children!['email'] as StringValueNode;

  set name(String value) {
    if (value.length < 1 || value.length > 100) {throw ArgumentError('name must be 1-100 characters');}
    final tree = this.$tree;
    if (tree != null) {
      final oldNode = this.name;
      final object = StringValue(value);
      final newSubtree = Tree(root: object);
      tree.replaceSubtree(node: oldNode, newSubtree: newSubtree);
    }
  }

  set email(String value) {
    if (value.length < 1 || value.length > 100) {throw ArgumentError('email must be 1-100 characters');}
    final tree = this.$tree;
    if (tree != null) {
      final oldNode = this.email;
      final object = StringValue(value);
      final newSubtree = Tree(root: object);
      tree.replaceSubtree(node: oldNode, newSubtree: newSubtree);
    }
  }


  @override
  UserNode clone() => UserNode(id: id);
}
