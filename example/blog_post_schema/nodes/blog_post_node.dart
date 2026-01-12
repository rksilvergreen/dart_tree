// GENERATED CODE - DO NOT MODIFY BY HAND
// Generated from blog_post_schema.dart

import 'package:dart_tree/dart_tree.dart';
import 'user_node.dart';

/// Generated TreeNode class for BlogPost
class BlogPostNode extends CollectionNode {
  BlogPostNode({super.id});

  StringValueNode get title => this.$children!['title'] as StringValueNode;
  StringValueNode? get author => this.$children?['author'] as StringValueNode?;
  StringValueNode get content => this.$children!['content'] as StringValueNode;
  ListTreeNode? get comments => this.$children?['comments'] as ListTreeNode?;
  UserNode? get user => this.$children?['user'] as UserNode?;

  set title(String value) {
    if (value.length < 1 || value.length > 100) {throw ArgumentError('title must be 1-100 characters');}
    final tree = this.$tree;
    if (tree != null) {
      final oldNode = this.title;
      final newNode = StringValueNode(value);
      final newSubtree = Tree(root: newNode);
      tree.replaceSubtree(node: oldNode, newSubtree: newSubtree);
    }
  }

  set author(String? value) {
    if (value == null) {
      // Remove node from tree
      final tree = this.$tree;
      if (tree != null) {
        final oldNode = this.author;
        if (oldNode != null) {
          tree.removeSubtree(oldNode);
        }
      }
      return;
    }
    if (value.length < 1 || value.length > 100) {throw ArgumentError('author must be 1-100 characters');}
    final tree = this.$tree;
    if (tree != null) {
      final oldNode = this.author;
      final newNode = StringValueNode(value);
      if (oldNode != null) {
        // Replace existing node
        final newSubtree = Tree(root: newNode);
        tree.replaceSubtree(node: oldNode, newSubtree: newSubtree);
      } else {
        // Add new node (property was null before)
        final newSubtree = Tree(root: newNode);
        tree.addSubtree(parent: this, key: 'author', subtree: newSubtree);
      }
    }
  }

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


  @override
  BlogPostNode clone() => BlogPostNode(id: id);
}
