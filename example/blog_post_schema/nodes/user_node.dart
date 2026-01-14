// GENERATED CODE - DO NOT MODIFY BY HAND
// Generated from blog_post_schema.dart

import 'package:dart_tree/dart_tree.dart';
import '../objects/user_object.dart';

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


  static void fromObject(Tree tree, TreeNode? parent, String key, UserObject object) {
    final parentRecord = tree.nodes[parent?.id];
    final pointer = Pointer.build(parentRecord?.pointer, key);
    final node = UserNode();
    tree.$nodes[node.id] = TreeNodeRecord(node: node, pointer: pointer, parent: parent?.id);
    parentRecord?.children[Edge(UserNode, key)] = node.id;

    StringValueNode.fromObject(tree, node, 'name', object.name);
    StringValueNode.fromObject(tree, node, 'email', object.email);
  }

  @override
  UserNode clone() => UserNode(id: id);
}
