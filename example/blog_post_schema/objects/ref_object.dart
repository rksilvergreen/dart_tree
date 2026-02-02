// GENERATED CODE - DO NOT MODIFY BY HAND
// Generated from blog_post_schema.dart

import 'package:dart_tree/dart_tree.dart';
import '../blog_post_schema_deserializers.dart';
import 'reference_object.dart';
import 'admin_object.dart';

/// Generated union class for Ref
class RefObject<T extends TreeObject> extends TreeObject {
  final ReferenceObject? _reference;
  final AdminObject? _admin;
  final T? _t;

  /// Creates a Ref with a ReferenceObject value.
  RefObject.reference(ReferenceObject reference) : _reference = reference, _admin = null, _t = null;

  /// Creates a Ref with a AdminObject value.
  RefObject.admin(AdminObject admin) : _admin = admin, _reference = null, _t = null;

  /// Creates a Ref with a T value.
  RefObject.t(T t) : _t = t, _reference = null, _admin = null;

  /// Returns true if this union contains a ReferenceObject.
  bool get isReference => _reference != null;

  /// Returns true if this union contains a AdminObject.
  bool get isAdmin => _admin != null;

  /// Returns true if this union contains a T.
  bool get isT => _t != null;

  /// Gets the value as ReferenceObject, or null if it's not that type.
  ReferenceObject? get asReference => _reference;

  /// Gets the value as AdminObject, or null if it's not that type.
  AdminObject? get asAdmin => _admin;

  /// Gets the value as T, or null if it's not that type.
  T? get asT => _t;

  @override
  String toJson() {
    if (_reference != null) return _reference.toJson();
    if (_admin != null) return _admin.toJson();
    if (_t != null) return _t.toJson();
    throw StateError('Union has no value set');
  }

  @override
  String toYaml() {
    if (_reference != null) return _reference.toYaml();
    if (_admin != null) return _admin.toYaml();
    if (_t != null) return _t.toYaml();
    throw StateError('Union has no value set');
  }

  /// Attempts to decode from JSON by trying each type in order.
  static RefObject<T> fromJson<T extends TreeObject>(String json, Deserializer<T> deserializer_T) {
    try {
      return RefObject.reference(ReferenceObject.fromJson(json));
    } catch (_) {
      try {
        return RefObject.admin(AdminObject.fromJson(json));
      } catch (_) {
        try {
          return RefObject.t(deserializer_T(json));
        } catch (e) {
          throw FormatException('Could not decode RefObject from JSON: $e');
        }
      }
    }
  }

  /// Attempts to decode from YAML by trying each type in order.
  static RefObject<T> fromYaml<T extends TreeObject>(String yaml, Deserializer<T> deserializer_T) {
    try {
      return RefObject.reference(ReferenceObject.fromYaml(yaml));
    } catch (_) {
      try {
        return RefObject.admin(AdminObject.fromYaml(yaml));
      } catch (_) {
        try {
          return RefObject.t(deserializer_T(yaml));
        } catch (e) {
          throw FormatException('Could not decode RefObject from YAML: $e');
        }
      }
    }
  }

  @override
  String toString() => 'RefObject($_reference, $_admin, $_t)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RefObject<T> && _reference == other._reference && _admin == other._admin && _t == other._t;

  @override
  int get hashCode => Object.hash(_reference, _admin, _t);
}
