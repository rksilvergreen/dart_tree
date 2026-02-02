// GENERATED CODE - DO NOT MODIFY BY HAND
// Generated from blog_post_schema.dart

import 'package:dart_tree/dart_tree.dart';
import 'comment_object.dart';
import 'user_object.dart';

/// Generated union class for Book
class BookObject<GORDON_BANKS extends TreeObject, U extends TreeObject> extends TreeObject {
  final CommentObject? _comment;
  final UserObject? _user;
  final GORDON_BANKS? _gordonBanks;
  final U? _u;

  /// Creates a Book with a CommentObject value.
  BookObject.comment(CommentObject comment) : _comment = comment, _user = null, _gordonBanks = null, _u = null;

  /// Creates a Book with a UserObject value.
  BookObject.user(UserObject user) : _user = user, _comment = null, _gordonBanks = null, _u = null;

  /// Creates a Book with a GORDON_BANKS value.
  BookObject.gordonBanks(GORDON_BANKS gordonBanks)
    : _gordonBanks = gordonBanks,
      _comment = null,
      _user = null,
      _u = null;

  /// Creates a Book with a U value.
  BookObject.u(U u) : _u = u, _comment = null, _user = null, _gordonBanks = null;

  /// Returns true if this union contains a CommentObject.
  bool get isComment => _comment != null;

  /// Returns true if this union contains a UserObject.
  bool get isUser => _user != null;

  /// Returns true if this union contains a GORDON_BANKS.
  bool get isGordonBanks => _gordonBanks != null;

  /// Returns true if this union contains a U.
  bool get isU => _u != null;

  /// Gets the value as CommentObject, or null if it's not that type.
  CommentObject? get asComment => _comment;

  /// Gets the value as UserObject, or null if it's not that type.
  UserObject? get asUser => _user;

  /// Gets the value as GORDON_BANKS, or null if it's not that type.
  GORDON_BANKS? get asGordonBanks => _gordonBanks;

  /// Gets the value as U, or null if it's not that type.
  U? get asU => _u;

  @override
  String toJson() {
    if (_comment != null) return _comment.toJson();
    if (_user != null) return _user.toJson();
    if (_gordonBanks != null) return _gordonBanks.toJson();
    if (_u != null) return _u.toJson();
    throw StateError('Union has no value set');
  }

  @override
  String toYaml() {
    if (_comment != null) return _comment.toYaml();
    if (_user != null) return _user.toYaml();
    if (_gordonBanks != null) return _gordonBanks.toYaml();
    if (_u != null) return _u.toYaml();
    throw StateError('Union has no value set');
  }

  /// Attempts to decode from JSON by trying each type in order.
  static BookObject<GORDON_BANKS, U> fromJson<GORDON_BANKS extends TreeObject, U extends TreeObject>(
    String json,
    TextParser<GORDON_BANKS> textParser_GORDON_BANKS,
    TextParser<U> textParser_U,
  ) {
    try {
      return BookObject.comment(CommentObject.fromJson(json));
    } catch (_) {
      try {
        return BookObject.user(UserObject.fromJson(json));
      } catch (_) {
        try {
          return BookObject.gordonBanks(textParser_GORDON_BANKS(json));
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
  static BookObject<GORDON_BANKS, U> fromYaml<GORDON_BANKS extends TreeObject, U extends TreeObject>(
    String yaml,
    TextParser<GORDON_BANKS> textParser_GORDON_BANKS,
    TextParser<U> textParser_U,
  ) {
    try {
      return BookObject.comment(CommentObject.fromYaml(yaml));
    } catch (_) {
      try {
        return BookObject.user(UserObject.fromYaml(yaml));
      } catch (_) {
        try {
          return BookObject.gordonBanks(textParser_GORDON_BANKS(yaml));
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

  @override
  String toString() => 'BookObject($_comment, $_user, $_gordonBanks, $_u)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BookObject<GORDON_BANKS, U> &&
          _comment == other._comment &&
          _user == other._user &&
          _gordonBanks == other._gordonBanks &&
          _u == other._u;

  @override
  int get hashCode => Object.hash(_comment, _user, _gordonBanks, _u);
}
