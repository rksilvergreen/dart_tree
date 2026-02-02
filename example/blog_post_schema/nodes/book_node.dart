// GENERATED CODE - DO NOT MODIFY BY HAND
// Generated from blog_post_schema.dart

import 'package:dart_tree/dart_tree.dart';
import 'comment_node.dart';
import 'user_node.dart';
import '../objects/book_object.dart';

/// Generated union node class for Book
class BookNode<T extends TreeNode, U extends TreeNode> {
  final CommentNode? _comment;
  final UserNode? _user;
  final T? _t;
  final U? _u;

  /// Creates a Book node with a CommentNode value.
  BookNode.comment(CommentNode comment) : _comment = comment, _user = null, _t = null, _u = null;

  /// Creates a Book node with a UserNode value.
  BookNode.user(UserNode user) : _user = user, _comment = null, _t = null, _u = null;

  /// Creates a Book node with a T value.
  BookNode.t(T t) : _t = t, _comment = null, _user = null, _u = null;

  /// Creates a Book node with a U value.
  BookNode.u(U u) : _u = u, _comment = null, _user = null, _t = null;

  /// Returns true if this union contains a CommentNode.
  bool get isComment => _comment != null;

  /// Returns true if this union contains a UserNode.
  bool get isUser => _user != null;

  /// Returns true if this union contains a T.
  bool get isT => _t != null;

  /// Returns true if this union contains a U.
  bool get isU => _u != null;

  /// Gets the value as CommentNode, or null if it's not that type.
  CommentNode? get asComment => _comment;

  /// Gets the value as UserNode, or null if it's not that type.
  UserNode? get asUser => _user;

  /// Gets the value as T, or null if it's not that type.
  T? get asT => _t;

  /// Gets the value as U, or null if it's not that type.
  U? get asU => _u;

  BookNode clone() {
    if (_comment != null) {
      return BookNode.comment(_comment.clone() as CommentNode);
    } else if (_user != null) {
      return BookNode.user(_user.clone() as UserNode);
    } else if (_t != null) {
      return BookNode.t(_t.clone() as T);
    } else if (_u != null) {
      return BookNode.u(_u.clone() as U);
    } else {
      throw StateError('Union has no value set');
    }
  }

  T accept<T>(TreeNodeVisitor<T> visitor) {
    if (_comment != null) return _comment.accept(visitor);
    else if (_user != null) return _user.accept(visitor);
    else if (_t != null) return _t.accept(visitor);
    else if (_u != null) return _u.accept(visitor);
    else throw StateError('Union has no value set');
  }

  String toString() => 'BookNode($_comment, $_user, $_t, $_u)';

  BookObject toObject() {
    if (_comment != null) {
      return BookObject.comment(_comment.toObject());
    } else if (_user != null) {
      return BookObject.user(_user.toObject());
    } else if (_t != null) {
      return BookObject.t(_t.toObject());
    } else if (_u != null) {
      return BookObject.u(_u.toObject());
    } else {
      throw StateError('Union has no value set');
    }
  }

  static void fromObject<T extends TreeObject, U extends TreeObject>(Tree tree, TreeNode? parent, String key, BookObject<T, U>? object, ObjectParser<T> objectParser_T, ObjectParser<U> objectParser_U) {
    if (object == null) return;

    if (object.isComment) {
      CommentNode.fromObject(tree, parent, key, object.asComment);
    } else if (object.isUser) {
      UserNode.fromObject(tree, parent, key, object.asUser);
    } else if (object.isT) {
      objectParser_T(tree, parent, key, object.asT!);
    } else if (object.isU) {
      objectParser_U(tree, parent, key, object.asU!);
    }
  }
}
