// GENERATED CODE - DO NOT MODIFY BY HAND
// Generated from blog_post_schema.dart

import 'package:dart_tree/dart_tree.dart';

/// Generated TreeNode class for Comment
class CommentNode extends CollectionNode {
  CommentNode({super.id});

  StringValueNode get content => this.$children!['content'] as StringValueNode;
  IntValueNode? get index => this.$children?['index'] as IntValueNode?;
  StringValueNode? get buffer => this.$children?['buffer'] as StringValueNode?;

  set content(String value) {
    if (value.length < 1 || value.length > 1000) {throw ArgumentError('content must be 1-1000 characters');}
    final tree = this.$tree;
    if (tree != null) {
      final oldNode = this.content;
      final newNode = StringValueNode(value);
      final newSubtree = Tree(root: newNode);
      tree.replaceSubtree(node: oldNode, newSubtree: newSubtree);
    }
  }

  set index(int? value) {
    if (value == null) {
      // Remove node from tree
      final tree = this.$tree;
      if (tree != null) {
        final oldNode = this.index;
        if (oldNode != null) {
          tree.removeSubtree(oldNode);
        }
      }
      return;
    }
    final tree = this.$tree;
    if (tree != null) {
      final oldNode = this.index;
      final newNode = IntValueNode(value);
      if (oldNode != null) {
        // Replace existing node
        final newSubtree = Tree(root: newNode);
        tree.replaceSubtree(node: oldNode, newSubtree: newSubtree);
      } else {
        // Add new node (property was null before)
        final newSubtree = Tree(root: newNode);
        tree.addSubtree(parent: this, key: 'index', subtree: newSubtree);
      }
    }
  }

  set buffer(String? value) {
    if (value == null) {
      // Remove node from tree
      final tree = this.$tree;
      if (tree != null) {
        final oldNode = this.buffer;
        if (oldNode != null) {
          tree.removeSubtree(oldNode);
        }
      }
      return;
    }
    final tree = this.$tree;
    if (tree != null) {
      final oldNode = this.buffer;
      final newNode = StringValueNode(value);
      if (oldNode != null) {
        // Replace existing node
        final newSubtree = Tree(root: newNode);
        tree.replaceSubtree(node: oldNode, newSubtree: newSubtree);
      } else {
        // Add new node (property was null before)
        final newSubtree = Tree(root: newNode);
        tree.addSubtree(parent: this, key: 'buffer', subtree: newSubtree);
      }
    }
  }


  @override
  CommentNode clone() => CommentNode(id: id);
}
