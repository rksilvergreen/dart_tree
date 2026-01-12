// GENERATED CODE - DO NOT MODIFY BY HAND
// Generated from union_test_schema.dart

import 'package:dart_tree/dart_tree.dart';
import 'string_or_int_node.dart';
import 'mixed_value_node.dart';

/// Generated TreeNode class for Config
class ConfigNode extends CollectionNode {
  ConfigNode({super.id});

  StringValueNode get name => $children!['name'] as StringValueNode;
  StringOrIntNode get port => $children!['port'] as StringOrIntNode;
  MixedValueNode? get value => $children?['value'] as MixedValueNode?;

  set name(String value) {
    final tree = $tree;
    if (tree != null) {
      final oldNode = name;
      final newNode = StringValueNode(value);
      final newSubtree = Tree(root: newNode);
      tree.replaceSubtree(node: oldNode, newSubtree: newSubtree);
    }
  }


  @override
  ConfigNode clone() => ConfigNode(id: id);
}
