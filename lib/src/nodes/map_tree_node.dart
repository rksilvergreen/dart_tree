import 'dart:collection';
import 'tree_node.dart';

/// Base class for map-like collection nodes.
///
/// Provides Map interface for accessing child nodes by string keys.
/// User-generated map collection nodes will extend this class.
///
/// Example generated code:
/// ```dart
/// class ResponsesMapNode extends MapTreeNode<ResponseNode> {
///   ResponsesMapNode();
/// }
/// ```
abstract class MapTreeNode<CHILD_NODE extends TreeNode> extends TreeNode with MapMixin<String, CHILD_NODE> {
  MapTreeNode({super.id, super.sourceRange, super.jsonFormatting, super.yamlFormatting});

  /// Internal map accessor via tree's children.
  Map<String, CHILD_NODE> get _map => $children?.cast<String, CHILD_NODE>() ?? {};

  @override
  CHILD_NODE? operator [](Object? key) {
    if (key is! String) return null;
    return _map[key];
  }

  @override
  void operator []=(String key, CHILD_NODE value) =>
      throw UnsupportedError('MapTreeNode is unmodifiable. Use Tree operations.');

  @override
  void clear() => throw UnsupportedError('MapTreeNode is unmodifiable. Use Tree operations.');

  @override
  CHILD_NODE? remove(Object? key) => throw UnsupportedError('MapTreeNode is unmodifiable. Use Tree operations.');

  @override
  Iterable<String> get keys => _map.keys;

  @override
  int get length => _map.length;

  @override
  MapTreeNode<CHILD_NODE> clone() {
    throw UnimplementedError('Use generated clone implementation');
  }
}
