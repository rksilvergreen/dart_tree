// GENERATED CODE - DO NOT MODIFY BY HAND
// Generated from union_test_schema.dart

import 'package:dart_tree/dart_tree.dart';

/// Generated union class for MixedValue
class MixedValueObject extends TreeObject {
  final TreeObject _value;

  MixedValueObject._(this._value);

  /// Creates a MixedValue with a StringValue value.
  factory MixedValueObject.string(StringValue value) => MixedValueObject._(value);

  /// Creates a MixedValue with a IntValue value.
  factory MixedValueObject.integer(IntValue value) => MixedValueObject._(value);

  /// Creates a MixedValue with a BoolValue value.
  factory MixedValueObject.boolean(BoolValue value) => MixedValueObject._(value);

  /// Returns true if this union contains a StringValue.
  bool get isString => _value is StringValue;

  /// Returns true if this union contains a IntValue.
  bool get isInteger => _value is IntValue;

  /// Returns true if this union contains a BoolValue.
  bool get isBoolean => _value is BoolValue;

  /// Gets the value as StringValue, or null if it's not that type.
  StringValue? get asString => isString ? _value as StringValue : null;

  /// Gets the value as IntValue, or null if it's not that type.
  IntValue? get asInteger => isInteger ? _value as IntValue : null;

  /// Gets the value as BoolValue, or null if it's not that type.
  BoolValue? get asBoolean => isBoolean ? _value as BoolValue : null;

  /// Gets the underlying value as TreeObject.
  TreeObject get value => _value;

  /// Pattern matching helper.
  R when<R>({required R Function(StringValue) string, required R Function(IntValue) integer, required R Function(BoolValue) boolean}) {
    if (isString) {
      return string(_value as StringValue);
    } else if (isInteger) {
      return integer(_value as IntValue);
    } else {
      return boolean(_value as BoolValue);
    }
  }

  @override
  String toJson() => _value.toJson();

  @override
  String toYaml() => _value.toYaml();

  /// Attempts to decode from JSON by trying each type in order.
  static MixedValueObject fromJson(String json, StringValue Function(String) fromJsonString, IntValue Function(String) fromJsonInteger, BoolValue Function(String) fromJsonBoolean) {
    try {
      return MixedValueObject.string(fromJsonString(json));
    } catch (_) {
    try {
      return MixedValueObject.integer(fromJsonInteger(json));
    } catch (_) {
    try {
      return MixedValueObject.boolean(fromJsonBoolean(json));
    } catch (e) {
      throw FormatException('Could not decode MixedValueObject from JSON: $e');
    }
    }
    }
  }

  /// Attempts to decode from YAML by trying each type in order.
  static MixedValueObject fromYaml(String yaml, StringValue Function(String) fromYamlString, IntValue Function(String) fromYamlInteger, BoolValue Function(String) fromYamlBoolean) {
    try {
      return MixedValueObject.string(fromYamlString(yaml));
    } catch (_) {
    try {
      return MixedValueObject.integer(fromYamlInteger(yaml));
    } catch (_) {
    try {
      return MixedValueObject.boolean(fromYamlBoolean(yaml));
    } catch (e) {
      throw FormatException('Could not decode MixedValueObject from YAML: $e');
    }
    }
    }
  }

  @override
  String toString() => 'MixedValueObject($_value)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MixedValueObject && runtimeType == other.runtimeType && _value == other._value;

  @override
  int get hashCode => Object.hash(runtimeType, _value);
}
