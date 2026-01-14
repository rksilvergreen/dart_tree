// GENERATED CODE - DO NOT MODIFY BY HAND
// Generated from blog_post_schema.dart

import 'package:dart_tree/dart_tree.dart';

/// Generated TreeNode class for Admin
class AdminNode extends CollectionNode {
  AdminNode({super.id});

  IntValueNode get age => this.$children!['age'] as IntValueNode;
  StringValueNode get address => this.$children!['address'] as StringValueNode;

  set age(int value) {
    if (value < 18.0) {throw ArgumentError('age must be >= 18.0');}
    final tree = this.$tree;
    if (tree != null) {
      final oldNode = this.age;
      final object = IntValue(value);
      final newSubtree = Tree(root: object);
      tree.replaceSubtree(node: oldNode, newSubtree: newSubtree);
    }
  }

  set address(String value) {
    if (value.length < 1 || value.length > 100) {throw ArgumentError('address must be 1-100 characters');}
    final tree = this.$tree;
    if (tree != null) {
      final oldNode = this.address;
      final object = StringValue(value);
      final newSubtree = Tree(root: object);
      tree.replaceSubtree(node: oldNode, newSubtree: newSubtree);
    }
  }


  @override
  AdminNode clone() => AdminNode(id: id);
}
