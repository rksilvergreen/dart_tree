// GENERATED CODE - DO NOT MODIFY BY HAND
// Generated from blog_post_schema.dart

import 'package:dart_tree/dart_tree.dart';

/// Generated TreeNode class for Comment
class CommentNode extends CollectionNode {
  CommentNode({super.id});

  StringValueNode get content => $children!['content'] as StringValueNode;

  set content(String value) {
    if (value.length < 1 || value.length > 1000) {throw ArgumentError('content must be 1-1000 characters');}
    final tree = $tree;
    if (tree != null) {
      final oldNode = content;
      final newNode = StringValueNode(value);
      final newSubtree = Tree(root: newNode);
      tree.replaceSubtree(node: oldNode, newSubtree: newSubtree);
    }
  }


  @override
  CommentNode clone() => CommentNode(id: id);
}
