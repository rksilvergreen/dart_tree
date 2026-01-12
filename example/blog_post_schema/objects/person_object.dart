// GENERATED CODE - DO NOT MODIFY BY HAND
// Generated from blog_post_schema.dart

import 'package:dart_tree/dart_tree.dart';
import 'user_object.dart';
import 'admin_object.dart';

/// Generated union class for Person
class PersonObject extends TreeObject {
  final TreeObject _value;

  PersonObject._(this._value);

  /// Creates a Person with a UserObject value.
  factory PersonObject.user(UserObject value) => PersonObject._(value);

  /// Creates a Person with a AdminObject value.
  factory PersonObject.admin(AdminObject value) => PersonObject._(value);

  /// Returns true if this union contains a UserObject.
  bool get isUser => _value is UserObject;

  /// Returns true if this union contains a AdminObject.
  bool get isAdmin => _value is AdminObject;

  /// Gets the value as UserObject, or null if it's not that type.
  UserObject? get asUser => isUser ? _value as UserObject : null;

  /// Gets the value as AdminObject, or null if it's not that type.
  AdminObject? get asAdmin => isAdmin ? _value as AdminObject : null;

  /// Gets the underlying value as TreeObject.
  TreeObject get value => _value;

  /// Pattern matching helper.
  R when<R>({required R Function(UserObject) user, required R Function(AdminObject) admin}) {
    if (isUser) {
      return user(_value as UserObject);
    } else {
      return admin(_value as AdminObject);
    }
  }

  @override
  String toJson() => _value.toJson();

  @override
  String toYaml() => _value.toYaml();

  /// Attempts to decode from JSON by trying each type in order.
  static PersonObject fromJson(String json, UserObject Function(String) fromJsonUser, AdminObject Function(String) fromJsonAdmin) {
    try {
      return PersonObject.user(fromJsonUser(json));
    } catch (_) {
    try {
      return PersonObject.admin(fromJsonAdmin(json));
    } catch (e) {
      throw FormatException('Could not decode PersonObject from JSON: $e');
    }
    }
  }

  /// Attempts to decode from YAML by trying each type in order.
  static PersonObject fromYaml(String yaml, UserObject Function(String) fromYamlUser, AdminObject Function(String) fromYamlAdmin) {
    try {
      return PersonObject.user(fromYamlUser(yaml));
    } catch (_) {
    try {
      return PersonObject.admin(fromYamlAdmin(yaml));
    } catch (e) {
      throw FormatException('Could not decode PersonObject from YAML: $e');
    }
    }
  }

  @override
  String toString() => 'PersonObject($_value)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PersonObject && runtimeType == other.runtimeType && _value == other._value;

  @override
  int get hashCode => Object.hash(runtimeType, _value);
}
