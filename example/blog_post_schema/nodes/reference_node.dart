// GENERATED CODE - DO NOT MODIFY BY HAND
// Generated from blog_post_schema.dart

import 'package:dart_tree/dart_tree.dart';
import '../objects/reference_object.dart';

/// Generated TreeNode class for Reference
class ReferenceNode extends CollectionNode {
  ReferenceNode({super.id});

  StringValueNode get $ref => this.$children!['\$ref'] as StringValueNode;

  Tree? set$ref(StringValue value) {
    Tree? removedSubtree;
    final tree = this.$tree;
    if (tree != null) {
      final oldNode = this.$ref;
      final newSubtree = Tree(root: value);
      removedSubtree = tree.replaceSubtree(node: oldNode, newSubtree: newSubtree);
    }
    return removedSubtree;
  }



  ReferenceObject toObject() => ReferenceObject(
    $ref: this.$ref.toObject(),
  );

  static void fromObject(Tree tree, TreeNode? parent, String key, ReferenceObject? object) {
    if (object == null) return;

    final parentRecord = tree.nodes[parent?.id];
    final pointer = Pointer.build(parentRecord?.pointer, key);
    final node = ReferenceNode();
    tree.$nodes[node.id] = TreeNodeRecord(node: node, pointer: pointer, parent: parent?.id);
    parentRecord?.children[Edge(ReferenceNode, key)] = node.id;

    StringValueNode.fromObject(tree, node, '\$ref', object.$ref);
  }

  @override
  ReferenceNode clone() => ReferenceNode(id: id);
}

/// Generated ListNode for Reference
class ReferencesListNode extends ListTreeNode<ReferenceNode> {
  ReferencesListNode({super.id});

  ReferencesListObject toObject() => ReferencesListObject(this.map((node) => node.toObject()).toList());

  static void fromObject(Tree tree, TreeNode? parent, String key, ReferencesListObject? object) {
    if (object == null) return;

    final parentRecord = tree.nodes[parent?.id];
    final pointer = Pointer.build(parentRecord?.pointer, key);
    final node = ReferencesListNode();
    tree.$nodes[node.id] = TreeNodeRecord(node: node, pointer: pointer, parent: parent?.id);
    parentRecord?.children[Edge(ReferencesListNode, key)] = node.id;

    for (int i = 0; i < object.length; i++) {
      ReferenceNode.fromObject(tree, node, i.toString(), object[i]);
    }
  }

  @override
  ReferencesListNode clone() => ReferencesListNode(id: id);
}
