// Copyright (c) 2024, dart_tree project authors. Adapted from json_annotation.
// Licensed under a BSD-style license.

/// Helper function used in generated `fromJson` code when validation is enabled.
///
/// Checks for allowed keys, required keys, and disallowed null values.
void $checkKeys(Map map, {List<String>? allowedKeys, List<String>? requiredKeys, List<String>? disallowNullValues}) {
  if (allowedKeys != null) {
    final invalidKeys = map.keys.cast<String>().where((k) => !allowedKeys.contains(k)).toList();
    if (invalidKeys.isNotEmpty) {
      throw UnrecognizedKeysException(invalidKeys, map, allowedKeys);
    }
  }

  if (requiredKeys != null) {
    final missingKeys = requiredKeys.where((k) => !map.keys.contains(k)).toList();
    if (missingKeys.isNotEmpty) {
      throw MissingRequiredKeysException(missingKeys, map);
    }
  }

  if (disallowNullValues != null) {
    final nullValuedKeys = map.entries
        .where((entry) => disallowNullValues.contains(entry.key) && entry.value == null)
        .map((entry) => entry.key as String)
        .toList();

    if (nullValuedKeys.isNotEmpty) {
      throw DisallowedNullValueException(nullValuedKeys, map);
    }
  }
}

/// Helper function used in generated `fromJson` code for checked deserialization.
///
/// Should not be used directly.
T $checkedCreate<T>(
  String className,
  Map map,
  T Function(S Function<S>(String, S Function(Object?), {Object? Function(Map, String)? readValue})) constructor, {
  Map<String, String> fieldKeyMap = const {},
}) {
  Q checkedConvert<Q>(String key, Q Function(Object?) convertFunction, {Object? Function(Map, String)? readValue}) =>
      $checkedConvert<Q>(map, key, convertFunction, readValue: readValue);

  return $checkedNew(className, map, () => constructor(checkedConvert), fieldKeyMap: fieldKeyMap);
}

/// Helper function used in generated code for checked object creation.
///
/// Should not be used directly.
T $checkedNew<T>(String className, Map map, T Function() constructor, {Map<String, String>? fieldKeyMap}) {
  fieldKeyMap ??= const {};

  try {
    return constructor();
  } on CheckedFromJsonException catch (e) {
    if (identical(e.map, map) && e._className == null) {
      e._className = className;
    }
    rethrow;
  } catch (error, stack) {
    String? key;
    if (error is ArgumentError) {
      key = fieldKeyMap[error.name] ?? error.name;
    } else if (error is MissingRequiredKeysException) {
      key = error.missingKeys.first;
    } else if (error is DisallowedNullValueException) {
      key = error.keysWithNullValues.first;
    }
    throw CheckedFromJsonException._(error, stack, map, key, className: className);
  }
}

/// Helper function used in generated code for checked value conversion.
///
/// Should not be used directly.
T $checkedConvert<T>(Map map, String key, T Function(dynamic) castFunc, {Object? Function(Map, String)? readValue}) {
  try {
    return castFunc(readValue == null ? map[key] : readValue(map, key));
  } on CheckedFromJsonException {
    rethrow;
  } catch (error, stack) {
    throw CheckedFromJsonException._(error, stack, map, key);
  }
}

// =============================================================================
// EXCEPTION CLASSES
// =============================================================================

/// A base class for exceptions thrown when decoding JSON.
abstract class BadKeyException implements Exception {
  BadKeyException._(this.map);

  /// The source [Map] that the unrecognized keys were found in.
  final Map map;

  /// A human-readable message corresponding to the error.
  String get message;

  @override
  String toString() => '$runtimeType: $message';
}

/// Exception thrown if there are unrecognized keys in a JSON map.
class UnrecognizedKeysException extends BadKeyException {
  /// The allowed keys for [map].
  final List<String> allowedKeys;

  /// The keys from [map] that were unrecognized.
  final List<String> unrecognizedKeys;

  @override
  String get message =>
      'Unrecognized keys: [${unrecognizedKeys.join(', ')}]; supported keys: '
      '[${allowedKeys.join(', ')}]';

  UnrecognizedKeysException(this.unrecognizedKeys, Map map, this.allowedKeys) : super._(map);
}

/// Exception thrown if there are missing required keys in a JSON map.
class MissingRequiredKeysException extends BadKeyException {
  /// The keys that [map] is missing.
  final List<String> missingKeys;

  @override
  String get message => 'Required keys are missing: ${missingKeys.join(', ')}.';

  MissingRequiredKeysException(this.missingKeys, Map map) : assert(missingKeys.isNotEmpty), super._(map);
}

/// Exception thrown if there are keys with disallowed `null` values.
class DisallowedNullValueException extends BadKeyException {
  final List<String> keysWithNullValues;

  DisallowedNullValueException(this.keysWithNullValues, Map map) : super._(map);

  @override
  String get message =>
      'These keys had `null` values, '
      'which is not allowed: $keysWithNullValues';
}

/// Exception thrown if there is a runtime exception in generated `fromJson` code.
class CheckedFromJsonException implements Exception {
  /// The [Error] or [Exception] that triggered this exception.
  final Object? innerError;

  /// The [StackTrace] for the [Error] or [Exception] that triggered this exception.
  final StackTrace? innerStack;

  /// The key from [map] that corresponds to the thrown [innerError].
  final String? key;

  /// The source [Map] that was used for decoding when the [innerError] was thrown.
  final Map map;

  /// A human-readable message corresponding to [innerError].
  final String? message;

  /// The name of the class being created when [innerError] was thrown.
  String? get className => _className;
  String? _className;

  /// If this was thrown due to an invalid or unsupported key.
  final bool badKey;

  /// Creates a new instance of [CheckedFromJsonException].
  CheckedFromJsonException(this.map, this.key, String className, this.message, {this.badKey = false})
    : _className = className,
      innerError = null,
      innerStack = null;

  CheckedFromJsonException._(Object this.innerError, this.innerStack, this.map, this.key, {String? className})
    : _className = className,
      badKey = innerError is BadKeyException,
      message = _getMessage(innerError);

  static String _getMessage(Object error) {
    if (error is ArgumentError) {
      final message = error.message;
      if (message != null) {
        return message.toString();
      }
    }
    if (error is BadKeyException) {
      return error.message;
    }
    if (error is FormatException) {
      var message = error.message;
      if (error.offset != null) {
        message = '$message at offset ${error.offset}.';
      }
      return message;
    }
    return error.toString();
  }

  @override
  String toString() => <String>[
    'CheckedFromJsonException',
    if (_className != null) 'Could not create `$_className`.',
    if (key != null) 'There is a problem with "$key".',
    if (message != null) message! else if (innerError != null) innerError.toString(),
  ].join('\n');
}
