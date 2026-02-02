// GENERATED CODE - DO NOT MODIFY BY HAND
// Generated from blog_post_schema.dart

import 'package:dart_tree/dart_tree.dart';
import 'reference_node.dart';
import 'admin_node.dart';
import '../objects/ref_object.dart';

/// Generated union node class for Ref
class RefNode<T extends TreeNode> extends TreeNode {
  final ReferenceNode? _reference;
  final AdminNode? _admin;
  final T? _t;

  /// Creates a Ref node with a ReferenceNode value.
  RefNode.reference(ReferenceNode reference, {super.id}) : _reference = reference, _admin = null, _t = null;

  /// Creates a Ref node with a AdminNode value.
  RefNode.admin(AdminNode admin, {super.id}) : _admin = admin, _reference = null, _t = null;

  /// Creates a Ref node with a T value.
  RefNode.t(T t, {super.id}) : _t = t, _reference = null, _admin = null;

  /// Returns true if this union contains a ReferenceNode.
  bool get isReference => _reference != null;

  /// Returns true if this union contains a AdminNode.
  bool get isAdmin => _admin != null;

  /// Returns true if this union contains a T.
  bool get isT => _t != null;

  /// Gets the value as ReferenceNode, or null if it's not that type.
  ReferenceNode? get asReference => _reference;

  /// Gets the value as AdminNode, or null if it's not that type.
  AdminNode? get asAdmin => _admin;

  /// Gets the value as T, or null if it's not that type.
  T? get asT => _t;

  @override
  RefNode clone() {
    if (_reference != null) {
      return RefNode.reference(_reference.clone() as ReferenceNode);
    } else if (_admin != null) {
      return RefNode.admin(_admin.clone() as AdminNode);
    } else if (_t != null) {
      return RefNode.t(_t.clone() as T);
    } else {
      throw StateError('Union has no value set');
    }
  }

  @override
  T accept<T>(TreeNodeVisitor<T> visitor) {
    if (_reference != null) return _reference.accept(visitor);
    else if (_admin != null) return _admin.accept(visitor);
    else if (_t != null) return _t.accept(visitor);
    else throw StateError('Union has no value set');
  }

  @override
  String toString() => 'RefNode($_reference, $_admin, $_t)';

  RefObject toObject() {
    if (_reference != null) {
      return RefObject.reference(_reference.toObject());
    } else if (_admin != null) {
      return RefObject.admin(_admin.toObject());
    } else if (_t != null) {
      return RefObject.t(_t.toObject());
    } else {
      throw StateError('Union has no value set');
    }
  }

  static void fromObject<T extends TreeObject>(Tree tree, TreeNode? parent, String key, RefObject<T>? object, ObjectParser<T> objectParser_T) {
    if (object == null) return;

    if (object.isReference) {
      ReferenceNode.fromObject(tree, parent, key, object.asReference);
    } else if (object.isAdmin) {
      AdminNode.fromObject(tree, parent, key, object.asAdmin);
    } else if (object.isT) {
      objectParser_T(tree, parent, key, object.asT!);
    }
  }
}
