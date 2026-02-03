// GENERATED CODE - DO NOT MODIFY BY HAND
// Generated from blog_post_schema.dart

import 'package:dart_tree/dart_tree.dart';
import '../objects/admin_object.dart';
import '../trees/blog_post_schema_tree.dart';

/// Generated TreeNode class for Admin
class AdminNode extends CollectionNode {
  AdminNode({super.id});

  IntValueNode get age => this.$children!['age'] as IntValueNode;
  StringValueNode get address => this.$children!['address'] as StringValueNode;

  Tree? setAge(IntValue value) {
    Tree? removedSubtree;
    final tree = this.$tree;
    if (tree != null) {
      final oldNode = this.age;
      final newSubtree = BlogPostSchemaTree.fromObject(root: value);
      removedSubtree = tree.replaceSubtree(node: oldNode, newSubtree: newSubtree);
    }
    return removedSubtree;
  }

  Tree? setAddress(StringValue value) {
    Tree? removedSubtree;
    final tree = this.$tree;
    if (tree != null) {
      final oldNode = this.address;
      final newSubtree = BlogPostSchemaTree.fromObject(root: value);
      removedSubtree = tree.replaceSubtree(node: oldNode, newSubtree: newSubtree);
    }
    return removedSubtree;
  }



  AdminObject toObject() => AdminObject(
    age: this.age.toObject(),
    address: this.address.toObject(),
  );

  static void fromObject(Tree tree, TreeNode? parent, String key, AdminObject? object) {
    if (object == null) return;

    final parentRecord = tree.nodes[parent?.id];
    final pointer = Pointer.build(parentRecord?.pointer, key);
    final node = AdminNode();
    tree.$nodes[node.id] = TreeNodeRecord(node: node, pointer: pointer, parent: parent?.id);
    parentRecord?.children[Edge(AdminNode, key)] = node.id;

    IntValueNode.fromObject(tree, node, 'age', object.age);
    StringValueNode.fromObject(tree, node, 'address', object.address);
  }

  @override
  AdminNode clone() => AdminNode(id: id);
}
