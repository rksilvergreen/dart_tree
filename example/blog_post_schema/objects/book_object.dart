// GENERATED CODE - DO NOT MODIFY BY HAND
// Generated from blog_post_schema.dart

import 'package:dart_tree/dart_tree.dart';
import 'comment_object.dart';
import 'user_object.dart';

/// Generated union class for Book
class BookObject<T extends TreeObject, U extends TreeObject> {
  final CommentObject? _comment;
  final UserObject? _user;
  final T? _t;
  final U? _u;

  /// Creates a Book with a CommentObject value.
  BookObject.comment(CommentObject comment) : _comment = comment, _user = null, _t = null, _u = null;

  /// Creates a Book with a UserObject value.
  BookObject.user(UserObject user) : _user = user, _comment = null, _t = null, _u = null;

  /// Creates a Book with a T value.
  BookObject.t(T t) : _t = t, _comment = null, _user = null, _u = null;

  /// Creates a Book with a U value.
  BookObject.u(U u) : _u = u, _comment = null, _user = null, _t = null;

  /// Returns true if this union contains a CommentObject.
  bool get isComment => _comment != null;

  /// Returns true if this union contains a UserObject.
  bool get isUser => _user != null;

  /// Returns true if this union contains a T.
  bool get isT => _t != null;

  /// Returns true if this union contains a U.
  bool get isU => _u != null;

  /// Gets the value as CommentObject, or null if it's not that type.
  CommentObject? get asComment => _comment;

  /// Gets the value as UserObject, or null if it's not that type.
  UserObject? get asUser => _user;

  /// Gets the value as T, or null if it's not that type.
  T? get asT => _t;

  /// Gets the value as U, or null if it's not that type.
  U? get asU => _u;

  String toJson() {
    if (_comment != null) return _comment.toJson();
    if (_user != null) return _user.toJson();
    if (_t != null) return _t.toJson();
    if (_u != null) return _u.toJson();
    throw StateError('Union has no value set');
  }

  String toYaml() {
    if (_comment != null) return _comment.toYaml();
    if (_user != null) return _user.toYaml();
    if (_t != null) return _t.toYaml();
    if (_u != null) return _u.toYaml();
    throw StateError('Union has no value set');
  }

  /// Attempts to decode from JSON by trying each type in order.
  static BookObject<T, U> fromJson<T extends TreeObject, U extends TreeObject>(String json, TextParser<T> textParser_T, TextParser<U> textParser_U) {
    try {
      return BookObject.comment(CommentObject.fromJson(json));
    } catch (_) {
    try {
      return BookObject.user(UserObject.fromJson(json));
    } catch (_) {
    try {
      return BookObject.t(textParser_T(json));
    } catch (_) {
    try {
      return BookObject.u(textParser_U(json));
    } catch (e) {
      throw FormatException('Could not decode BookObject from JSON: $e');
    }
    }
    }
    }
  }

  /// Attempts to decode from YAML by trying each type in order.
  static BookObject<T, U> fromYaml<T extends TreeObject, U extends TreeObject>(String yaml, TextParser<T> textParser_T, TextParser<U> textParser_U) {
    try {
      return BookObject.comment(CommentObject.fromYaml(yaml));
    } catch (_) {
    try {
      return BookObject.user(UserObject.fromYaml(yaml));
    } catch (_) {
    try {
      return BookObject.t(textParser_T(yaml));
    } catch (_) {
    try {
      return BookObject.u(textParser_U(yaml));
    } catch (e) {
      throw FormatException('Could not decode BookObject from YAML: $e');
    }
    }
    }
    }
  }

  String toString() => 'BookObject($_comment, $_user, $_t, $_u)';

  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BookObject<T, U> &&
      _comment == other._comment &&
      _user == other._user &&
      _t == other._t &&
      _u == other._u;

  int get hashCode => Object.hash(_comment, _user, _t, _u);
}
