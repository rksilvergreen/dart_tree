// GENERATED CODE - DO NOT MODIFY BY HAND
// Generated from blog_post_schema.dart

import 'package:dart_tree/dart_tree.dart';
import 'reference_node.dart';
import '../objects/ref_object.dart';
import '../objects/reference_object.dart';

/// Generated union node class for Ref
class RefNode<T extends TreeNode> extends TreeNode {
  final ReferenceNode? _reference;
  final T? _value;

  /// Creates a Ref node with a ReferenceNode value.
  RefNode.reference(ReferenceNode reference, {super.id}) : _reference = reference, _value = null;

  /// Creates a Ref node with a T value.
  RefNode.value(T value, {super.id}) : _value = value, _reference = null;

  /// Returns true if this union contains a ReferenceNode.
  bool get isReference => _reference != null;

  /// Returns true if this union contains a T.
  bool get isValue => _value != null;

  /// Gets the value as ReferenceNode, or null if it's not that type.
  ReferenceNode? get asReference => _reference;

  /// Gets the value as T, or null if it's not that type.
  T? get asValue => _value;

  @override
  RefNode clone() {
    if (_reference != null) {
      return RefNode.reference(_reference.clone() as ReferenceNode);
    } else if (_value != null) {
      return RefNode.value(_value.clone() as T);
    } else {
      throw StateError('Union has no value set');
    }
  }

  @override
  T accept<T>(TreeNodeVisitor<T> visitor) {
    if (_reference != null) return _reference.accept(visitor);
    else if (_value != null) return _value.accept(visitor);
    else throw StateError('Union has no value set');
  }

  @override
  String toString() => 'RefNode($_reference, $_value)';

  static void fromObject(Tree tree, TreeNode? parent, String key, RefObject? object) {
    if (object == null) return;

    if (object.isReference) {
      ReferenceNode.fromObject(tree, parent, key, object.asReference);
    } else if (object.isValue) {
      // Type parameter deserialization not supported
      throw UnsupportedError('Cannot deserialize union with type parameter T');
    }
  }
}
