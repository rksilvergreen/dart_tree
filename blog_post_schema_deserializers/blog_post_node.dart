// GENERATED CODE - DO NOT MODIFY BY HAND
// Generated from blog_post_schema.dart

import 'package:dart_tree/dart_tree.dart';
import 'comment_node.dart';
import 'user_node.dart';
import 'ref_node.dart';
import 'reference_node.dart';
import 'admin_node.dart';
import '../objects/blog_post_object.dart';
import '../objects/comment_object.dart';
import '../objects/user_object.dart';
import '../objects/ref_object.dart';

/// Generated TreeNode class for BlogPost
class BlogPostNode<T extends TreeNode, U extends TreeNode> extends CollectionNode {
  BlogPostNode({super.id});

  StringValueNode get title => this.$children!['title'] as StringValueNode;
  StringValueNode? get author => this.$children?['author'] as StringValueNode?;
  StringValueNode get content => this.$children!['content'] as StringValueNode;
  CommentsListNode? get comments => this.$children?['comments'] as CommentsListNode?;
  T? get extra => this.$children?['extra'] as T?;
  UserNode? get user => this.$children?['user'] as UserNode?;
  RefNode<U>? get champion {
    final child = this.$children?['champion'];
    Type type = child.runtimeType;
    if (type == ReferenceNode) return RefNode.reference(child as ReferenceNode);
    if (type == AdminNode) return RefNode.admin(child as AdminNode);
    if (type == U) return RefNode.t(child as U);
    return null;
  }

  final Map<String, List<Type>> edgeMap = {
    'title': [StringValueNode],
    'author': [StringValueNode],
    'content': [StringValueNode],
    'comments': [CommentsListNode],
    'extra': [T],
    'user': [UserNode],
    'champion': [ReferenceNode, AdminNode, U],
  };

  Tree? setTitle(StringValue value) {
    Tree? removedSubtree;
    final tree = this.$tree;
    if (tree != null) {
      final oldNode = this.title;
      final newSubtree = Tree(root: value);
      removedSubtree = tree.replaceSubtree(node: oldNode, newSubtree: newSubtree);
    }
    return removedSubtree;
  }

  Tree? setAuthor(StringValue? value) {
    Tree? removedSubtree;
    if (value == null) {
      // Remove node from tree
      final tree = this.$tree;
      if (tree != null) {
        final oldNode = this.author;
        if (oldNode != null) {
          removedSubtree = tree.removeSubtree(oldNode);
        }
      }
      return removedSubtree;
    }
    final tree = this.$tree;
    if (tree != null) {
      final oldNode = this.author;
      if (oldNode != null) {
        // Replace existing node
        final newSubtree = Tree(root: value);
        removedSubtree = tree.replaceSubtree(node: oldNode, newSubtree: newSubtree);
      } else {
        // Add new node (property was null before)
        final newSubtree = Tree(root: value);
        tree.addSubtree(parent: this, key: 'author', subtree: newSubtree);
      }
    }
    return removedSubtree;
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

  Tree? setComments(CommentsListObject? value) {
    Tree? removedSubtree;
    if (value == null) {
      // Remove node from tree
      final tree = this.$tree;
      if (tree != null) {
        final oldNode = this.comments;
        if (oldNode != null) {
          removedSubtree = tree.removeSubtree(oldNode);
        }
      }
      return removedSubtree;
    }
    final tree = this.$tree;
    if (tree != null) {
      final oldNode = this.comments;
      final tempTree = Tree(root: value);
      final rootNode = tempTree.root;
      if (rootNode != null) {
        final subtree = tempTree.removeSubtree(rootNode);
        if (oldNode != null) {
          // Replace existing node
          removedSubtree = tree.replaceSubtree(node: oldNode, newSubtree: subtree);
        } else {
          // Add new node (property was null before)
          tree.addSubtree(parent: this, key: 'comments', subtree: subtree);
        }
      }
    }
    return removedSubtree;
  }

  Tree? setExtra(TreeObject? value) {
    Tree? removedSubtree;
    if (value == null) {
      // Remove node from tree
      final tree = this.$tree;
      if (tree != null) {
        final oldNode = this.extra;
        if (oldNode != null) {
          removedSubtree = tree.removeSubtree(oldNode);
        }
      }
      return removedSubtree;
    }
    final tree = this.$tree;
    if (tree != null) {
      final oldNode = this.extra;
      final tempTree = Tree(root: value);
      final rootNode = tempTree.root;
      if (rootNode != null) {
        final subtree = tempTree.removeSubtree(rootNode);
        try {
          if (oldNode != null) {
            // Replace existing node
            removedSubtree = tree.replaceSubtree(node: oldNode, newSubtree: subtree);
          } else {
            // Add new node (property was null before)
            tree.addSubtree(parent: this, key: 'extra', subtree: subtree);
          }
        } on StateError {
          print('Can\'t set field to type ${value.runtimeType}');
        }
      }
    }
    return removedSubtree;
  }

  Tree? setUser(UserObject? value) {
    Tree? removedSubtree;
    if (value == null) {
      // Remove node from tree
      final tree = this.$tree;
      if (tree != null) {
        final oldNode = this.user;
        if (oldNode != null) {
          removedSubtree = tree.removeSubtree(oldNode);
        }
      }
      return removedSubtree;
    }
    final tree = this.$tree;
    if (tree != null) {
      final oldNode = this.user;
      final tempTree = Tree(root: value);
      final rootNode = tempTree.root;
      if (rootNode != null) {
        final subtree = tempTree.removeSubtree(rootNode);
        if (oldNode != null) {
          // Replace existing node
          removedSubtree = tree.replaceSubtree(node: oldNode, newSubtree: subtree);
        } else {
          // Add new node (property was null before)
          tree.addSubtree(parent: this, key: 'user', subtree: subtree);
        }
      }
    }
    return removedSubtree;
  }

  Tree? setChampion(RefObject? value) {
    Tree? removedSubtree;
    if (value == null) {
      // Remove node from tree
      final tree = this.$tree;
      if (tree != null) {
        final oldNode = this.$children?['champion'] as TreeNode?;
        if (oldNode != null) {
          removedSubtree = tree.removeSubtree(oldNode);
        }
      }
      return removedSubtree;
    }
    final tree = this.$tree;
    if (tree != null) {
      final oldNode = this.$children?['champion'] as TreeNode?;
      final tempTree = Tree(root: value);
      final rootNode = tempTree.root;
      if (rootNode != null) {
        final subtree = tempTree.removeSubtree(rootNode);
        if (oldNode != null) {
          // Replace existing node
          removedSubtree = tree.replaceSubtree(node: oldNode, newSubtree: subtree);
        } else {
          // Add new node (property was null before)
          tree.addSubtree(parent: this, key: 'champion', subtree: subtree);
        }
      }
    }
    return removedSubtree;
  }

  BlogPostObject toObject() => BlogPostObject(
    title: this.title.toObject(),
    author: this.author?.toObject(),
    content: this.content.toObject(),
    comments: this.comments?.toObject(),
    extra: this.extra?.toObject(),
    user: this.user?.toObject(),
    champion: this.champion?.toObject() as RefObject?,
  );

  static void fromObject<T extends TreeObject, U extends TreeObject>(
    Tree tree,
    TreeNode? parent,
    String key,
    BlogPostObject<T, U>? object,
  ) {
    if (object == null) return;

    final parentRecord = tree.nodes[parent?.id];
    final pointer = Pointer.build(parentRecord?.pointer, key);
    final result = _objectToNodeMap[object.runtimeType]!;
    final node = result.constructor();
    final nodeType = result.type;
    tree.$nodes[node.id] = TreeNodeRecord(node: node, pointer: pointer, parent: parent?.id);
    parentRecord?.children[Edge(nodeType, key)] = node.id;

    StringValueNode.fromObject(tree, node, 'title', object.title);
    StringValueNode.fromObject(tree, node, 'author', object.author);
    StringValueNode.fromObject(tree, node, 'content', object.content);
    CommentsListNode.fromObject(tree, node, 'comments', object.comments);
    if (object.extra != null) {
      final tempTree = Tree(root: object.extra!);
      final rootNode = tempTree.root;
      if (rootNode != null) {
        final subtree = tempTree.removeSubtree(rootNode);
        tree.addSubtree(parent: node, key: 'extra', subtree: subtree);
      }
    }
    UserNode.fromObject(tree, node, 'user', object.user);
    RefNode.fromObject(tree, node, 'champion', object.champion);
  }

  @override
  BlogPostNode clone() => BlogPostNode(id: id);
}

final Map<Type, ({Type type, TreeNode Function() constructor})> _objectToNodeMap = {
  BlogPostObject<StringValue, StringValue>: (
    type: BlogPostNode<StringValueNode, StringValueNode>,
    constructor: () => BlogPostNode<StringValueNode, StringValueNode>(),
  ),
};
