import 'tree_object.dart';

/// Represents a value that can be one of two types.
///
/// Union objects allow expressing "either/or" relationships in the domain model
/// while maintaining type safety.
///
/// Example:
/// ```dart
/// // A field that can be either a string or an integer
/// @treeObject
/// class Config extends TreeObject {
///   final UnionObject2<StringValue, IntValue> port;
///
///   Config({required this.port});
/// }
///
/// // Usage
/// final config1 = Config(port: UnionObject2.first(StringValue('8080')));
/// final config2 = Config(port: UnionObject2.second(IntValue(8080)));
/// ```
class UnionObject2<T1 extends TreeObject, T2 extends TreeObject> extends TreeObject {
  final TreeObject _value;

  UnionObject2._(this._value);

  /// Creates a union object with the first type.
  factory UnionObject2.first(T1 value) => UnionObject2._(value);

  /// Creates a union object with the second type.
  factory UnionObject2.second(T2 value) => UnionObject2._(value);

  /// Returns true if this union contains the first type.
  bool get isFirst => _value is T1;

  /// Returns true if this union contains the second type.
  bool get isSecond => _value is T2;

  /// Gets the value as the first type, or null if it's not that type.
  T1? get asFirst => isFirst ? _value as T1 : null;

  /// Gets the value as the second type, or null if it's not that type.
  T2? get asSecond => isSecond ? _value as T2 : null;

  /// Gets the underlying value as TreeObject.
  TreeObject get value => _value;

  /// Pattern matching helper.
  R when<R>({required R Function(T1) first, required R Function(T2) second}) {
    if (isFirst) {
      return first(_value as T1);
    } else {
      return second(_value as T2);
    }
  }

  @override
  String toJson() => _value.toJson();

  @override
  String toYaml() => _value.toYaml();

  /// Attempts to decode from JSON by trying each type in order.
  static UnionObject2<T1, T2> fromJson<T1 extends TreeObject, T2 extends TreeObject>(
    dynamic json,
    T1 Function(dynamic) fromJsonT1,
    T2 Function(dynamic) fromJsonT2,
  ) {
    try {
      return UnionObject2.first(fromJsonT1(json));
    } catch (_) {
      try {
        return UnionObject2.second(fromJsonT2(json));
      } catch (e) {
        throw ArgumentError('Could not decode UnionObject2 from JSON: $e');
      }
    }
  }

  /// Attempts to decode from YAML by trying each type in order.
  static UnionObject2<T1, T2> fromYaml<T1 extends TreeObject, T2 extends TreeObject>(
    dynamic yaml,
    T1 Function(dynamic) fromYamlT1,
    T2 Function(dynamic) fromYamlT2,
  ) {
    try {
      return UnionObject2.first(fromYamlT1(yaml));
    } catch (_) {
      try {
        return UnionObject2.second(fromYamlT2(yaml));
      } catch (e) {
        throw ArgumentError('Could not decode UnionObject2 from YAML: $e');
      }
    }
  }

  @override
  String toString() => 'UnionObject2<$T1,$T2>($_value)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UnionObject2<T1, T2> && runtimeType == other.runtimeType && _value == other._value;

  @override
  int get hashCode => Object.hash(runtimeType, _value);
}

/// Represents a value that can be one of three types.
///
/// Example:
/// ```dart
/// @treeObject
/// class Response extends TreeObject {
///   final UnionObject3<StringValue, IntValue, BoolValue> value;
///
///   Response({required this.value});
/// }
/// ```
class UnionObject3<T1 extends TreeObject, T2 extends TreeObject, T3 extends TreeObject> extends TreeObject {
  final TreeObject _value;

  UnionObject3._(this._value);

  /// Creates a union object with the first type.
  factory UnionObject3.first(T1 value) => UnionObject3._(value);

  /// Creates a union object with the second type.
  factory UnionObject3.second(T2 value) => UnionObject3._(value);

  /// Creates a union object with the third type.
  factory UnionObject3.third(T3 value) => UnionObject3._(value);

  /// Returns true if this union contains the first type.
  bool get isFirst => _value is T1;

  /// Returns true if this union contains the second type.
  bool get isSecond => _value is T2;

  /// Returns true if this union contains the third type.
  bool get isThird => _value is T3;

  /// Gets the value as the first type, or null if it's not that type.
  T1? get asFirst => isFirst ? _value as T1 : null;

  /// Gets the value as the second type, or null if it's not that type.
  T2? get asSecond => isSecond ? _value as T2 : null;

  /// Gets the value as the third type, or null if it's not that type.
  T3? get asThird => isThird ? _value as T3 : null;

  /// Gets the underlying value as TreeObject.
  TreeObject get value => _value;

  /// Pattern matching helper.
  R when<R>({required R Function(T1) first, required R Function(T2) second, required R Function(T3) third}) {
    if (isFirst) {
      return first(_value as T1);
    } else if (isSecond) {
      return second(_value as T2);
    } else {
      return third(_value as T3);
    }
  }

  @override
  String toJson() => _value.toJson();

  @override
  String toYaml() => _value.toYaml();

  @override
  String toString() => 'UnionObject3<$T1,$T2,$T3>($_value)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UnionObject3<T1, T2, T3> && runtimeType == other.runtimeType && _value == other._value;

  @override
  int get hashCode => Object.hash(runtimeType, _value);
}

/// Represents a value that can be one of four types.
///
/// Example:
/// ```dart
/// @treeObject
/// class SchemaType extends TreeObject {
///   final UnionObject4<StringValue, IntValue, ArraySchema, ObjectSchema> schema;
/// }
/// ```
class UnionObject4<T1 extends TreeObject, T2 extends TreeObject, T3 extends TreeObject, T4 extends TreeObject>
    extends TreeObject {
  final TreeObject _value;

  UnionObject4._(this._value);

  factory UnionObject4.first(T1 value) => UnionObject4._(value);
  factory UnionObject4.second(T2 value) => UnionObject4._(value);
  factory UnionObject4.third(T3 value) => UnionObject4._(value);
  factory UnionObject4.fourth(T4 value) => UnionObject4._(value);

  bool get isFirst => _value is T1;
  bool get isSecond => _value is T2;
  bool get isThird => _value is T3;
  bool get isFourth => _value is T4;

  T1? get asFirst => isFirst ? _value as T1 : null;
  T2? get asSecond => isSecond ? _value as T2 : null;
  T3? get asThird => isThird ? _value as T3 : null;
  T4? get asFourth => isFourth ? _value as T4 : null;

  TreeObject get value => _value;

  R when<R>({
    required R Function(T1) first,
    required R Function(T2) second,
    required R Function(T3) third,
    required R Function(T4) fourth,
  }) {
    if (isFirst) {
      return first(_value as T1);
    } else if (isSecond) {
      return second(_value as T2);
    } else if (isThird) {
      return third(_value as T3);
    } else {
      return fourth(_value as T4);
    }
  }

  @override
  String toJson() => _value.toJson();

  @override
  String toYaml() => _value.toYaml();

  @override
  String toString() => 'UnionObject4<$T1,$T2,$T3,$T4>($_value)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UnionObject4<T1, T2, T3, T4> && runtimeType == other.runtimeType && _value == other._value;

  @override
  int get hashCode => Object.hash(runtimeType, _value);
}
