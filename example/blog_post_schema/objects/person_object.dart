// GENERATED CODE - DO NOT MODIFY BY HAND
// Generated from blog_post_schema.dart

import 'package:dart_tree/dart_tree.dart';
import '../blog_post_schema_deserializers.dart' as deserializers;
import 'user_object.dart';
import 'admin_object.dart';

/// Generated union class for Person
class PersonObject<T extends TreeObject, U extends TreeObject> extends TreeObject {
  final UserObject? _user;
  final AdminObject? _admin;
  final T? _value;
  final U? _ref;

  /// Creates a Person with a UserObject value.
  PersonObject.user(UserObject user) : _user = user, _admin = null, _value = null, _ref = null;

  /// Creates a Person with a AdminObject value.
  PersonObject.admin(AdminObject admin) : _admin = admin, _user = null, _value = null, _ref = null;

  /// Creates a Person with a T value.
  PersonObject.value(T value) : _value = value, _user = null, _admin = null, _ref = null;

  /// Creates a Person with a U value.
  PersonObject.ref(U ref) : _ref = ref, _user = null, _admin = null, _value = null;

  /// Returns true if this union contains a UserObject.
  bool get isUser => _user != null;

  /// Returns true if this union contains a AdminObject.
  bool get isAdmin => _admin != null;

  /// Returns true if this union contains a T.
  bool get isValue => _value != null;

  /// Returns true if this union contains a U.
  bool get isRef => _ref != null;

  /// Gets the value as UserObject, or null if it's not that type.
  UserObject? get asUser => _user;

  /// Gets the value as AdminObject, or null if it's not that type.
  AdminObject? get asAdmin => _admin;

  /// Gets the value as T, or null if it's not that type.
  T? get asValue => _value;

  /// Gets the value as U, or null if it's not that type.
  U? get asRef => _ref;

  @override
  String toJson() {
    if (_user != null) return _user.toJson();
    if (_admin != null) return _admin.toJson();
    if (_value != null) return _value.toJson();
    if (_ref != null) return _ref.toJson();
    throw StateError('Union has no value set');
  }

  @override
  String toYaml() {
    if (_user != null) return _user.toYaml();
    if (_admin != null) return _admin.toYaml();
    if (_value != null) return _value.toYaml();
    if (_ref != null) return _ref.toYaml();
    throw StateError('Union has no value set');
  }

  /// Attempts to decode from JSON by trying each type in order.
  static PersonObject<T, U> fromJson<T extends TreeObject, U extends TreeObject>(String json) {
    try {
      return PersonObject.user(UserObject.fromJson(json));
    } catch (_) {
    try {
      return PersonObject.admin(AdminObject.fromJson(json));
    } catch (_) {
    try {
      return PersonObject.value(deserializers.fromJson<T>(json));
    } catch (_) {
    try {
      return PersonObject.ref(deserializers.fromJson<U>(json));
    } catch (e) {
      throw FormatException('Could not decode PersonObject from JSON: $e');
    }
    }
    }
    }
  }

  /// Attempts to decode from YAML by trying each type in order.
  static PersonObject<T, U> fromYaml<T extends TreeObject, U extends TreeObject>(String yaml) {
    try {
      return PersonObject.user(UserObject.fromYaml(yaml));
    } catch (_) {
    try {
      return PersonObject.admin(AdminObject.fromYaml(yaml));
    } catch (_) {
    try {
      return PersonObject.value(deserializers.fromYaml<T>(yaml));
    } catch (_) {
    try {
      return PersonObject.ref(deserializers.fromYaml<U>(yaml));
    } catch (e) {
      throw FormatException('Could not decode PersonObject from YAML: $e');
    }
    }
    }
    }
  }

  @override
  String toString() => 'PersonObject($_user, $_admin, $_value, $_ref)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PersonObject<T, U> &&
      _user == other._user &&
      _admin == other._admin &&
      _value == other._value &&
      _ref == other._ref;

  @override
  int get hashCode => Object.hash(_user, _admin, _value, _ref);
}
