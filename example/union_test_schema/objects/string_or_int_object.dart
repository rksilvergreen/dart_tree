// GENERATED CODE - DO NOT MODIFY BY HAND
// Generated from union_test_schema.dart

import 'package:dart_tree/dart_tree.dart';

/// Generated union class for StringOrInt
class StringOrIntObject extends TreeObject {
  final TreeObject _value;

  StringOrIntObject._(this._value);

  /// Creates a StringOrInt with a StringValue value.
  factory StringOrIntObject.string(StringValue value) => StringOrIntObject._(value);

  /// Creates a StringOrInt with a IntValue value.
  factory StringOrIntObject.integer(IntValue value) => StringOrIntObject._(value);

  /// Returns true if this union contains a StringValue.
  bool get isString => _value is StringValue;

  /// Returns true if this union contains a IntValue.
  bool get isInteger => _value is IntValue;

  /// Gets the value as StringValue, or null if it's not that type.
  StringValue? get asString => isString ? _value as StringValue : null;

  /// Gets the value as IntValue, or null if it's not that type.
  IntValue? get asInteger => isInteger ? _value as IntValue : null;

  /// Gets the underlying value as TreeObject.
  TreeObject get value => _value;

  /// Pattern matching helper.
  R when<R>({required R Function(StringValue) string, required R Function(IntValue) integer}) {
    if (isString) {
      return string(_value as StringValue);
    } else {
      return integer(_value as IntValue);
    }
  }

  @override
  String toJson() => _value.toJson();

  @override
  String toYaml() => _value.toYaml();

  /// Attempts to decode from JSON by trying each type in order.
  static StringOrIntObject fromJson(String json, StringValue Function(String) fromJsonString, IntValue Function(String) fromJsonInteger) {
    try {
      return StringOrIntObject.string(fromJsonString(json));
    } catch (_) {
    try {
      return StringOrIntObject.integer(fromJsonInteger(json));
    } catch (e) {
      throw FormatException('Could not decode StringOrIntObject from JSON: $e');
    }
    }
  }

  /// Attempts to decode from YAML by trying each type in order.
  static StringOrIntObject fromYaml(String yaml, StringValue Function(String) fromYamlString, IntValue Function(String) fromYamlInteger) {
    try {
      return StringOrIntObject.string(fromYamlString(yaml));
    } catch (_) {
    try {
      return StringOrIntObject.integer(fromYamlInteger(yaml));
    } catch (e) {
      throw FormatException('Could not decode StringOrIntObject from YAML: $e');
    }
    }
  }

  @override
  String toString() => 'StringOrIntObject($_value)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StringOrIntObject && runtimeType == other.runtimeType && _value == other._value;

  @override
  int get hashCode => Object.hash(runtimeType, _value);
}
