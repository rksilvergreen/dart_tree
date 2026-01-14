// GENERATED CODE - DO NOT MODIFY BY HAND
// Generated from blog_post_schema.dart

import 'package:dart_tree/dart_tree.dart';
import '../blog_post_schema_deserializers.dart' as deserializers;
import 'user_object.dart';
import 'admin_object.dart';

/// Generated union class for Person
class PersonObject extends TreeObject {
  final UserObject? _user;
  final AdminObject? _admin;

  /// Creates a Person with a UserObject value.
  PersonObject.user(UserObject user) : _user = user, _admin = null;

  /// Creates a Person with a AdminObject value.
  PersonObject.admin(AdminObject admin) : _admin = admin, _user = null;

  /// Returns true if this union contains a UserObject.
  bool get isUser => _user != null;

  /// Returns true if this union contains a AdminObject.
  bool get isAdmin => _admin != null;

  /// Gets the value as UserObject, or null if it's not that type.
  UserObject? get asUser => _user;

  /// Gets the value as AdminObject, or null if it's not that type.
  AdminObject? get asAdmin => _admin;

  @override
  String toJson() {
    if (_user != null) return _user.toJson();
    if (_admin != null) return _admin.toJson();
    throw StateError('Union has no value set');
  }

  @override
  String toYaml() {
    if (_user != null) return _user.toYaml();
    if (_admin != null) return _admin.toYaml();
    throw StateError('Union has no value set');
  }

  /// Attempts to decode from JSON by trying each type in order.
  static PersonObject fromJson(String json) {
    try {
      return PersonObject.user(UserObject.fromJson(json));
    } catch (_) {
    try {
      return PersonObject.admin(AdminObject.fromJson(json));
    } catch (e) {
      throw FormatException('Could not decode PersonObject from JSON: $e');
    }
    }
  }

  /// Attempts to decode from YAML by trying each type in order.
  static PersonObject fromYaml(String yaml) {
    try {
      return PersonObject.user(UserObject.fromYaml(yaml));
    } catch (_) {
    try {
      return PersonObject.admin(AdminObject.fromYaml(yaml));
    } catch (e) {
      throw FormatException('Could not decode PersonObject from YAML: $e');
    }
    }
  }

  @override
  String toString() => 'PersonObject($_user, $_admin)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PersonObject &&
      _user == other._user &&
      _admin == other._admin;

  @override
  int get hashCode => Object.hash(_user, _admin);
}
