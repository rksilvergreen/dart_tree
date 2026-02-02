// GENERATED CODE - DO NOT MODIFY BY HAND
// Generated from blog_post_schema.dart

import 'package:dart_tree/dart_tree.dart';
import 'person_node.dart';
import 'user_node.dart';
import 'admin_node.dart';
import 'ref_node.dart';
import 'reference_node.dart';
import '../objects/comment_object.dart';
import '../objects/person_object.dart';
import '../objects/ref_object.dart';
import '../objects/user_object.dart';

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
  RefNode<UserNode>? get ref {
    final child = this.$children?['ref'];
    return switch (child.runtimeType) {
      ReferenceNode => RefNode<UserNode>.reference(child as ReferenceNode),
      AdminNode => RefNode<UserNode>.admin(child as AdminNode),
      UserNode => RefNode<UserNode>.t(child as UserNode),
      _ => null,
    };
  }

  Tree? setContent(StringValue value) {
    Tree? removedSubtree;
    final tree = this.$tree;
    if (tree != null) {
      final oldNode = this.content;
      final newSubtree = Tree(root: value);
      removedSubtree = tree.replaceSubtree(node: oldNode, newSubtree: newSubtree);
    }
    return removedSubtree;
  }

  Tree? setIndex(IntValue? value) {
    Tree? removedSubtree;
    if (value == null) {
      // Remove node from tree
      final tree = this.$tree;
      if (tree != null) {
        final oldNode = this.index;
        if (oldNode != null) {
          removedSubtree = tree.removeSubtree(oldNode);
        }
      }
      return removedSubtree;
    }
    final tree = this.$tree;
    if (tree != null) {
      final oldNode = this.index;
      if (oldNode != null) {
        // Replace existing node
        final newSubtree = Tree(root: value);
        removedSubtree = tree.replaceSubtree(node: oldNode, newSubtree: newSubtree);
      } else {
        // Add new node (property was null before)
        final newSubtree = Tree(root: value);
        tree.addSubtree(parent: this, key: 'index', subtree: newSubtree);
      }
    }
    return removedSubtree;
  }

  Tree? setBuffer(StringValue? value) {
    Tree? removedSubtree;
    if (value == null) {
      // Remove node from tree
      final tree = this.$tree;
      if (tree != null) {
        final oldNode = this.buffer;
        if (oldNode != null) {
          removedSubtree = tree.removeSubtree(oldNode);
        }
      }
      return removedSubtree;
    }
    final tree = this.$tree;
    if (tree != null) {
      final oldNode = this.buffer;
      if (oldNode != null) {
        // Replace existing node
        final newSubtree = Tree(root: value);
        removedSubtree = tree.replaceSubtree(node: oldNode, newSubtree: newSubtree);
      } else {
        // Add new node (property was null before)
        final newSubtree = Tree(root: value);
        tree.addSubtree(parent: this, key: 'buffer', subtree: newSubtree);
      }
    }
    return removedSubtree;
  }


  Tree? setPerson(PersonObject? value) {
    Tree? removedSubtree;
    if (value == null) {
      // Remove node from tree
      final tree = this.$tree;
      if (tree != null) {
        final oldNode = this.$children?['person'] as TreeNode?;
        if (oldNode != null) {
          removedSubtree = tree.removeSubtree(oldNode);
        }
      }
      return removedSubtree;
    }
    final tree = this.$tree;
    if (tree != null) {
      final oldNode = this.$children?['person'] as TreeNode?;
      final tempTree = Tree(root: value);
      final rootNode = tempTree.root;
      if (rootNode != null) {
        final subtree = tempTree.removeSubtree(rootNode);
        if (oldNode != null) {
          // Replace existing node
          removedSubtree = tree.replaceSubtree(node: oldNode, newSubtree: subtree);
        } else {
          // Add new node (property was null before)
          tree.addSubtree(parent: this, key: 'person', subtree: subtree);
        }
      }
    }
    return removedSubtree;
  }

  Tree? setRef(RefObject<UserObject>? value) {
    Tree? removedSubtree;
    if (value == null) {
      // Remove node from tree
      final tree = this.$tree;
      if (tree != null) {
        final oldNode = this.$children?['ref'] as TreeNode?;
        if (oldNode != null) {
          removedSubtree = tree.removeSubtree(oldNode);
        }
      }
      return removedSubtree;
    }
    final tree = this.$tree;
    if (tree != null) {
      final oldNode = this.$children?['ref'] as TreeNode?;
      final tempTree = Tree(root: value);
      final rootNode = tempTree.root;
      if (rootNode != null) {
        final subtree = tempTree.removeSubtree(rootNode);
        if (oldNode != null) {
          // Replace existing node
          removedSubtree = tree.replaceSubtree(node: oldNode, newSubtree: subtree);
        } else {
          // Add new node (property was null before)
          tree.addSubtree(parent: this, key: 'ref', subtree: subtree);
        }
      }
    }
    return removedSubtree;
  }


  CommentObject toObject() => CommentObject(
    content: this.content.toObject(),
    index: this.index?.toObject(),
    buffer: this.buffer?.toObject(),
    person: this.person?.toObject() as PersonObject?,
    ref: this.ref?.toObject() as RefObject<UserObject>?,
  );

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
    RefNode.fromObject<UserObject>(tree, node, 'ref', object.ref, (Tree t, TreeNode? p, String k, UserObject o) => UserNode.fromObject(t, p, k, o));
  }

  @override
  CommentNode clone() => CommentNode(id: id);
}

/// Generated ListNode for Comment
class CommentsListNode extends ListTreeNode<CommentNode> {
  CommentsListNode({super.id});

  CommentsListObject toObject() => CommentsListObject(this.map((node) => node.toObject()).toList());

  static void fromObject(Tree tree, TreeNode? parent, String key, CommentsListObject? object) {
    if (object == null) return;

    final parentRecord = tree.nodes[parent?.id];
    final pointer = Pointer.build(parentRecord?.pointer, key);
    final node = CommentsListNode();
    tree.$nodes[node.id] = TreeNodeRecord(node: node, pointer: pointer, parent: parent?.id);
    parentRecord?.children[Edge(CommentsListNode, key)] = node.id;

    for (int i = 0; i < object.length; i++) {
      CommentNode.fromObject(tree, node, i.toString(), object[i]);
    }
  }

  @override
  CommentsListNode clone() => CommentsListNode(id: id);
}
