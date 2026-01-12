// GENERATED CODE - DO NOT MODIFY BY HAND
// Generated from blog_post_schema.dart

import 'package:dart_tree/dart_tree.dart';
import 'user_node.dart';
import 'admin_node.dart';

/// Generated union node class for Person
class PersonNode extends TreeNode {
  final TreeNode _value;

  PersonNode._(this._value, {super.id});

  /// Creates a Person node with a UserNode value.
  factory PersonNode.user(UserNode value, {String? id}) {
    return PersonNode._(value, id: id);
  }

  /// Creates a Person node with a AdminNode value.
  factory PersonNode.admin(AdminNode value, {String? id}) {
    return PersonNode._(value, id: id);
  }

  /// Returns true if this union contains a UserNode.
  bool get isUser => _value is UserNode;

  /// Returns true if this union contains a AdminNode.
  bool get isAdmin => _value is AdminNode;

  /// Gets the value as UserNode, or null if it's not that type.
  UserNode? get asUser => isUser ? _value as UserNode : null;

  /// Gets the value as AdminNode, or null if it's not that type.
  AdminNode? get asAdmin => isAdmin ? _value as AdminNode : null;

  /// Gets the underlying value.
  TreeNode get value => _value;

  /// Pattern matching helper.
  T when<T>({required T Function(UserNode) user, required T Function(AdminNode) admin}) {
    if (isUser) {
      return user(_value as UserNode);
    } else {
      return admin(_value as AdminNode);
    }
  }

  @override
  PersonNode clone() {
    final clonedValue = _value.clone();
    if (clonedValue is UserNode) {
      return PersonNode.user(clonedValue);
    } else {
      return PersonNode.admin(clonedValue);
    }
  }

  @override
  T accept<T>(TreeNodeVisitor<T> visitor) => _value.accept(visitor);

  @override
  String toString() => 'PersonNode($_value)';
}
