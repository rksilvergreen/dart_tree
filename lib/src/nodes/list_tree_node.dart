import 'dart:collection';
import 'tree_node.dart';

/// Base class for list-like collection nodes.
///
/// Provides List interface for accessing child nodes by index.
/// User-generated list collection nodes will extend this class.
///
/// Example generated code:
/// ```dart
/// class ParametersListNode extends ListTreeNode<ParameterNode> {
///   ParametersListNode();
/// }
/// ```
abstract class ListTreeNode<CHILD_NODE extends TreeNode> extends TreeNode with ListMixin<CHILD_NODE> {
  ListTreeNode({super.id});

  /// Internal list accessor via tree's children.
  List<CHILD_NODE> get _list => $children?.values.cast<CHILD_NODE>().toList() ?? [];

  @override
  int get length => _list.length;

  @override
  set length(int newLength) => throw UnsupportedError('ListTreeNode is unmodifiable. Use Tree operations.');

  @override
  CHILD_NODE operator [](int index) => _list[index];

  @override
  void operator []=(int index, CHILD_NODE value) =>
      throw UnsupportedError('ListTreeNode is unmodifiable. Use Tree operations.');

  @override
  List<CHILD_NODE> toList({bool growable = true}) => _list.toList(growable: growable);

  @override
  ListTreeNode<CHILD_NODE> clone() {
    throw UnimplementedError('Use generated clone implementation');
  }
}
