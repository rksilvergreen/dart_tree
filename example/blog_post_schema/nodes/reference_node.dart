// GENERATED CODE - DO NOT MODIFY BY HAND
// Generated from blog_post_schema.dart

import 'package:dart_tree/dart_tree.dart';

/// Generated TreeNode class for Reference
class ReferenceNode extends CollectionNode {
  ReferenceNode({super.id});

  StringValueNode? get $ref => this.$children?['\$ref'] as StringValueNode?;

  set $ref(String? value) {
    if (value == null) {
      // Remove node from tree
      final tree = this.$tree;
      if (tree != null) {
        final oldNode = this.$ref;
        if (oldNode != null) {
          tree.removeSubtree(oldNode);
        }
      }
      return;
    }
    final tree = this.$tree;
    if (tree != null) {
      final oldNode = this.$ref;
      final object = StringValue(value);
      if (oldNode != null) {
        // Replace existing node
        final newSubtree = Tree(root: object);
        tree.replaceSubtree(node: oldNode, newSubtree: newSubtree);
      } else {
        // Add new node (property was null before)
        final newSubtree = Tree(root: object);
        tree.addSubtree(parent: this, key: '\$ref', subtree: newSubtree);
      }
    }
  }


  @override
  ReferenceNode clone() => ReferenceNode(id: id);
}
