// GENERATED CODE - DO NOT MODIFY BY HAND
// Generated from blog_post_schema.dart

import 'package:dart_tree/dart_tree.dart';
import 'comment_node.dart';
import 'user_node.dart';
import 'book_node.dart';
import 'reference_node.dart';
import '../objects/blog_post_object.dart';
import '../objects/comment_object.dart';
import '../objects/user_object.dart';
import '../objects/book_object.dart';
import '../objects/reference_object.dart';

/// Generated TreeNode class for BlogPost
class BlogPostNode extends CollectionNode {
  BlogPostNode({super.id});

  StringValueNode get title => this.$children!['title'] as StringValueNode;
  StringValueNode? get author => this.$children?['author'] as StringValueNode?;
  StringValueNode get content => this.$children!['content'] as StringValueNode;
  CommentsListNode? get comments => this.$children?['comments'] as CommentsListNode?;
  UserNode? get user => this.$children?['user'] as UserNode?;
  BookNode? get book {
    final child = this.$children?['book'];
    return switch (child.runtimeType) {
      CommentNode => BookNode.comment(child as CommentNode),
      UserNode => BookNode.user(child as UserNode),
      TreeNode => BookNode.t(child as TreeNode),
      TreeNode => BookNode.u(child as TreeNode),
      _ => null,
    };
  }
  LibraryListNode? get library => this.$children?['library'] as LibraryListNode?;

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

  Tree? setBook(BookObject<_typeArg_TListObject, AdminObject>? value) {
    Tree? removedSubtree;
    if (value == null) {
      // Remove node from tree
      final tree = this.$tree;
      if (tree != null) {
        final oldNode = this.$children?['book'] as TreeNode?;
        if (oldNode != null) {
          removedSubtree = tree.removeSubtree(oldNode);
        }
      }
      return removedSubtree;
    }
    final tree = this.$tree;
    if (tree != null) {
      final oldNode = this.$children?['book'] as TreeNode?;
      final tempTree = Tree(root: value);
      final rootNode = tempTree.root;
      if (rootNode != null) {
        final subtree = tempTree.removeSubtree(rootNode);
        if (oldNode != null) {
          // Replace existing node
          removedSubtree = tree.replaceSubtree(node: oldNode, newSubtree: subtree);
        } else {
          // Add new node (property was null before)
          tree.addSubtree(parent: this, key: 'book', subtree: subtree);
        }
      }
    }
    return removedSubtree;
  }

  Tree? setLibrary(LibraryListObject? value) {
    Tree? removedSubtree;
    if (value == null) {
      // Remove node from tree
      final tree = this.$tree;
      if (tree != null) {
        final oldNode = this.library;
        if (oldNode != null) {
          removedSubtree = tree.removeSubtree(oldNode);
        }
      }
      return removedSubtree;
    }
    final tree = this.$tree;
    if (tree != null) {
      final oldNode = this.library;
      final tempTree = Tree(root: value);
      final rootNode = tempTree.root;
      if (rootNode != null) {
        final subtree = tempTree.removeSubtree(rootNode);
        if (oldNode != null) {
          // Replace existing node
          removedSubtree = tree.replaceSubtree(node: oldNode, newSubtree: subtree);
        } else {
          // Add new node (property was null before)
          tree.addSubtree(parent: this, key: 'library', subtree: subtree);
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
    user: this.user?.toObject(),
    book: this.book?.toObject() as BookObject<_typeArg_TListObject, AdminObject>?,
    library: this.library?.toObject(),
  );

  static void fromObject(Tree tree, TreeNode? parent, String key, BlogPostObject? object) {
    if (object == null) return;

    final parentRecord = tree.nodes[parent?.id];
    final pointer = Pointer.build(parentRecord?.pointer, key);
    final node = BlogPostNode();
    tree.$nodes[node.id] = TreeNodeRecord(node: node, pointer: pointer, parent: parent?.id);
    parentRecord?.children[Edge(BlogPostNode, key)] = node.id;

    StringValueNode.fromObject(tree, node, 'title', object.title);
    StringValueNode.fromObject(tree, node, 'author', object.author);
    StringValueNode.fromObject(tree, node, 'content', object.content);
    CommentsListNode.fromObject(tree, node, 'comments', object.comments);
    UserNode.fromObject(tree, node, 'user', object.user);
    BookNode.fromObject(tree, node, 'book', object.book);
    LibraryListNode.fromObject(tree, node, 'library', object.library);
  }

  @override
  BlogPostNode clone() => BlogPostNode(id: id);
}
