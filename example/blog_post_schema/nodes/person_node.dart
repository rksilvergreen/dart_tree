// GENERATED CODE - DO NOT MODIFY BY HAND
// Generated from blog_post_schema.dart

import 'package:dart_tree/dart_tree.dart';
import 'user_node.dart';
import 'admin_node.dart';

/// Generated union node class for Person
class PersonNode<T extends TreeNode, U extends TreeNode> extends TreeNode {
  final UserNode? _user;
  final AdminNode? _admin;
  final T? _value;
  final U? _ref;

  /// Creates a Person node with a UserNode value.
  PersonNode.user(UserNode user, {super.id}) : _user = user, _admin = null, _value = null, _ref = null;

  /// Creates a Person node with a AdminNode value.
  PersonNode.admin(AdminNode admin, {super.id}) : _admin = admin, _user = null, _value = null, _ref = null;

  /// Creates a Person node with a T value.
  PersonNode.value(T value, {super.id}) : _value = value, _user = null, _admin = null, _ref = null;

  /// Creates a Person node with a U value.
  PersonNode.ref(U ref, {super.id}) : _ref = ref, _user = null, _admin = null, _value = null;

  /// Returns true if this union contains a UserNode.
  bool get isUser => _user != null;

  /// Returns true if this union contains a AdminNode.
  bool get isAdmin => _admin != null;

  /// Returns true if this union contains a T.
  bool get isValue => _value != null;

  /// Returns true if this union contains a U.
  bool get isRef => _ref != null;

  /// Gets the value as UserNode, or null if it's not that type.
  UserNode? get asUser => _user;

  /// Gets the value as AdminNode, or null if it's not that type.
  AdminNode? get asAdmin => _admin;

  /// Gets the value as T, or null if it's not that type.
  T? get asValue => _value;

  /// Gets the value as U, or null if it's not that type.
  U? get asRef => _ref;

  @override
  PersonNode clone() {
    if (_user != null) {
      return PersonNode.user(_user.clone() as UserNode);
    } else if (_admin != null) {
      return PersonNode.admin(_admin.clone() as AdminNode);
    } else if (_value != null) {
      return PersonNode.value(_value.clone() as T);
    } else if (_ref != null) {
      return PersonNode.ref(_ref.clone() as U);
    } else {
      throw StateError('Union has no value set');
    }
  }

  @override
  T accept<T>(TreeNodeVisitor<T> visitor) {
    if (_user != null) return _user.accept(visitor);
    else if (_admin != null) return _admin.accept(visitor);
    else if (_value != null) return _value.accept(visitor);
    else if (_ref != null) return _ref.accept(visitor);
    else throw StateError('Union has no value set');
  }

  @override
  String toString() => 'PersonNode($_user, $_admin, $_value, $_ref)';
}
