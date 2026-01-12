// GENERATED CODE - DO NOT MODIFY BY HAND
// Generated from blog_post_schema.dart

import 'package:dart_tree/dart_tree.dart';
import '../blog_post_schema_deserializers.dart' as deserializers;
import 'reference_object.dart';

/// Generated union class for Ref
class RefObject<T extends TreeObject> extends TreeObject {
  final ReferenceObject? _reference;
  final T? _value;

  /// Creates a Ref with a ReferenceObject value.
  RefObject.reference(ReferenceObject reference) : _reference = reference, _value = null;

  /// Creates a Ref with a T value.
  RefObject.value(T value) : _value = value, _reference = null;

  /// Returns true if this union contains a ReferenceObject.
  bool get isReference => _reference != null;

  /// Returns true if this union contains a T.
  bool get isValue => _value != null;

  /// Gets the value as ReferenceObject, or null if it's not that type.
  ReferenceObject? get asReference => _reference;

  /// Gets the value as T, or null if it's not that type.
  T? get asValue => _value;

  @override
  String toJson() {
    if (_reference != null) return _reference.toJson();
    if (_value != null) return _value.toJson();
    throw StateError('Union has no value set');
  }

  @override
  String toYaml() {
    if (_reference != null) return _reference.toYaml();
    if (_value != null) return _value.toYaml();
    throw StateError('Union has no value set');
  }

  /// Attempts to decode from JSON by trying each type in order.
  static RefObject<T> fromJson<T extends TreeObject>(String json) {
    try {
      return RefObject.reference(ReferenceObject.fromJson(json));
    } catch (_) {
    try {
      return RefObject.value(deserializers.fromJson<T>(json));
    } catch (e) {
      throw FormatException('Could not decode RefObject from JSON: $e');
    }
    }
  }

  /// Attempts to decode from YAML by trying each type in order.
  static RefObject<T> fromYaml<T extends TreeObject>(String yaml) {
    try {
      return RefObject.reference(ReferenceObject.fromYaml(yaml));
    } catch (_) {
    try {
      return RefObject.value(deserializers.fromYaml<T>(yaml));
    } catch (e) {
      throw FormatException('Could not decode RefObject from YAML: $e');
    }
    }
  }

  @override
  String toString() => 'RefObject($_reference, $_value)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RefObject<T> &&
      _reference == other._reference &&
      _value == other._value;

  @override
  int get hashCode => Object.hash(_reference, _value);
}
