// GENERATED CODE - DO NOT MODIFY BY HAND
// Generated from blog_post_schema.dart

import 'package:dart_tree/dart_tree.dart';
import 'person_node.dart';
import 'user_node.dart';
import 'admin_node.dart';
import '../objects/comment_object.dart';
import '../objects/person_object.dart';
import '../objects/user_object.dart';
import '../objects/admin_object.dart';

/// Generated TreeNode class for Comment
class CommentNode extends CollectionNode {
  CommentNode({super.id});

  StringValueNode get content => this.$children!['content'] as StringValueNode;
  IntValueNode? get index => this.$children?['index'] as IntValueNode?;
  StringValueNode? get buffer => this.$children?['buffer'] as StringValueNode?;
  PersonNode? get person {
    final child = this.$children?['person'];
    return switch (child.runtimeType) {
      UserNode => PersonNode.user(child as UserNode),
      AdminNode => PersonNode.admin(child as AdminNode),
      _ => null,
    };
  }

  set content(String value) {
    if (value.length < 1 || value.length > 1000) {throw ArgumentError('content must be 1-1000 characters');}
    final tree = this.$tree;
    if (tree != null) {
      final oldNode = this.content;
      final object = StringValue(value);
      final newSubtree = Tree(root: object);
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
      final object = IntValue(value);
      if (oldNode != null) {
        // Replace existing node
        final newSubtree = Tree(root: object);
        tree.replaceSubtree(node: oldNode, newSubtree: newSubtree);
      } else {
        // Add new node (property was null before)
        final newSubtree = Tree(root: object);
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
      final object = StringValue(value);
      if (oldNode != null) {
        // Replace existing node
        final newSubtree = Tree(root: object);
        tree.replaceSubtree(node: oldNode, newSubtree: newSubtree);
      } else {
        // Add new node (property was null before)
        final newSubtree = Tree(root: object);
        tree.addSubtree(parent: this, key: 'buffer', subtree: newSubtree);
      }
    }
  }


  static void fromObject(Tree tree, TreeNode? parent, String key, CommentObject? object) {
    if (object == null) return;

    final parentRecord = tree.nodes[parent?.id];
    final pointer = Pointer.build(parentRecord?.pointer, key);
    final node = CommentNode();
    tree.$nodes[node.id] = TreeNodeRecord(node: node, pointer: pointer, parent: parent?.id);
    parentRecord?.children[Edge(CommentNode, key)] = node.id;

    StringValueNode.fromObject(tree, node, 'content', object.content);
    IntValueNode.fromObject(tree, node, 'index', object.index);
    StringValueNode.fromObject(tree, node, 'buffer', object.buffer);
    PersonNode.fromObject(tree, node, 'person', object.person);
  }

  @override
  CommentNode clone() => CommentNode(id: id);
}

/// Generated ListNode for comments
class CommentsListNode extends ListTreeNode<CommentNode> {
  CommentsListNode({super.id});

  @override
  CommentsListNode clone() => CommentsListNode(id: id);
}
