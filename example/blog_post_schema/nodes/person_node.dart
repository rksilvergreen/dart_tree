// GENERATED CODE - DO NOT MODIFY BY HAND
// Generated from blog_post_schema.dart

import 'package:dart_tree/dart_tree.dart';
import 'user_node.dart';
import 'admin_node.dart';
import '../objects/person_object.dart';
import '../objects/user_object.dart';
import '../objects/admin_object.dart';

/// Generated union node class for Person
class PersonNode extends TreeNode {
  final UserNode? _user;
  final AdminNode? _admin;

  /// Creates a Person node with a UserNode value.
  PersonNode.user(UserNode user, {super.id}) : _user = user, _admin = null;

  /// Creates a Person node with a AdminNode value.
  PersonNode.admin(AdminNode admin, {super.id}) : _admin = admin, _user = null;

  /// Returns true if this union contains a UserNode.
  bool get isUser => _user != null;

  /// Returns true if this union contains a AdminNode.
  bool get isAdmin => _admin != null;

  /// Gets the value as UserNode, or null if it's not that type.
  UserNode? get asUser => _user;

  /// Gets the value as AdminNode, or null if it's not that type.
  AdminNode? get asAdmin => _admin;

  @override
  PersonNode clone() {
    if (_user != null) {
      return PersonNode.user(_user.clone() as UserNode);
    } else if (_admin != null) {
      return PersonNode.admin(_admin.clone() as AdminNode);
    } else {
      throw StateError('Union has no value set');
    }
  }

  @override
  T accept<T>(TreeNodeVisitor<T> visitor) {
    if (_user != null) return _user.accept(visitor);
    else if (_admin != null) return _admin.accept(visitor);
    else throw StateError('Union has no value set');
  }

  @override
  String toString() => 'PersonNode($_user, $_admin)';

  static void fromObject(Tree tree, TreeNode? parent, String key, PersonObject? object) {
    if (object == null) return;

    if (object.isUser) {
      UserNode.fromObject(tree, parent, key, object.asUser);
    } else if (object.isAdmin) {
      AdminNode.fromObject(tree, parent, key, object.asAdmin);
    }
  }
}
