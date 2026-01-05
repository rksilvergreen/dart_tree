import 'dart:collection';
import 'tree_object.dart';
import '../syntax/json_formatting.dart';
import '../syntax/yaml_formatting.dart';

/// Base class for map-like collection objects.
///
/// Provides Map interface for accessing child objects by string keys.
/// User-defined map collection objects will extend this class.
///
/// Example:
/// ```dart
/// @treeObject
/// class ResponsesMap extends MapObject<Response> {
///   ResponsesMap(super.entries);
/// }
/// ```
abstract class MapObject<CHILD_OBJECT extends TreeObject> extends TreeObject with MapMixin<String, CHILD_OBJECT> {
  /// The internal map storage.
  final Map<String, CHILD_OBJECT> _entries;

  /// JSON-specific object styling.
  final JsonObjectStyle? jsonObjectStyle;

  /// YAML-specific mapping styling.
  final YamlMappingStyle? yamlMappingStyle;

  MapObject(
    Map<String, CHILD_OBJECT> entries, {
    super.sourceRange,
    super.jsonFormatting,
    super.yamlFormatting,
    this.jsonObjectStyle,
    this.yamlMappingStyle,
  }) : _entries = entries;

  @override
  CHILD_OBJECT? operator [](Object? key) => _entries[key];

  @override
  void operator []=(String key, CHILD_OBJECT value) => _entries[key] = value;

  @override
  void clear() => _entries.clear();

  @override
  CHILD_OBJECT? remove(Object? key) => _entries.remove(key);

  @override
  Iterable<String> get keys => _entries.keys;

  @override
  String toJson({String indent = '  ', bool prettyPrint = true}) {
    final singleLine = jsonObjectStyle?.singleLine ?? !prettyPrint;
    final propertyKeys = jsonObjectStyle?.propertyOrder ?? keys.toList();
    final buffer = StringBuffer();

    // Opening brace with whitespace
    if (jsonObjectStyle?.whitespaceBefore != null) {
      buffer.write(jsonObjectStyle!.whitespaceBefore);
    }
    buffer.write('{');
    if (jsonObjectStyle?.whitespaceAfterOpen != null) {
      buffer.write(jsonObjectStyle!.whitespaceAfterOpen);
    } else if (!singleLine) {
      buffer.writeln();
    }

    // Properties
    int index = 0;
    for (final key in propertyKeys) {
      if (!containsKey(key)) continue;

      if (!singleLine) {
        buffer.write(indent);
      }
      buffer.write('"$key"');
      buffer.write(':');
      if (!singleLine || singleLine) {
        buffer.write(' ');
      }
      buffer.write(this[key]!.toJson());
      if (index < propertyKeys.length - 1) {
        buffer.write(',');
        if (singleLine) {
          buffer.write(' ');
        } else {
          buffer.writeln();
        }
      }
      index++;
    }

    // Closing brace with whitespace
    if (!singleLine) {
      buffer.writeln();
    }
    if (jsonObjectStyle?.whitespaceBeforeClose != null) {
      buffer.write(jsonObjectStyle!.whitespaceBeforeClose);
    }
    buffer.write('}');
    if (jsonObjectStyle?.whitespaceAfter != null) {
      buffer.write(jsonObjectStyle!.whitespaceAfter);
    }

    return buffer.toString();
  }

  @override
  String toYaml({String indent = '  '}) {
    final isFlow = yamlMappingStyle?.style == YamlCollectionStyle.flow;
    final propertyKeys = yamlMappingStyle?.propertyOrder ?? keys.toList();
    final buffer = StringBuffer();

    if (isFlow) {
      // Flow style: {key1: value1, key2: value2}
      buffer.write('{');
      int index = 0;
      for (final key in propertyKeys) {
        if (!containsKey(key)) continue;
        buffer.write('$key: ');
        buffer.write(this[key]!.toYaml());
        if (index < propertyKeys.length - 1) {
          buffer.write(', ');
        }
        index++;
      }
      buffer.write('}');
    } else {
      // Block style
      int index = 0;
      for (final key in propertyKeys) {
        if (!containsKey(key)) continue;
        buffer.write('$key: ');
        buffer.write(this[key]!.toYaml());
        if (index < propertyKeys.length - 1) {
          buffer.writeln();
        }
        index++;
      }
    }

    return buffer.toString();
  }

  /// Parses a JSON object string to a MapObject.
  ///
  /// Input should be the full object string, e.g., `'{"key": "value"}'`
  ///
  /// Subclasses must override this to provide type-specific decoding.
  /// Use the parsing utilities to extract field strings, then recursively
  /// call fromJson on each value.
  static MapObject<TreeObject> fromJson(String json) {
    throw UnimplementedError('fromJson must be implemented by subclasses');
  }

  /// Parses a YAML mapping string to a MapObject.
  ///
  /// Input can be flow style `"{key: value}"` or block style with key-value pairs
  ///
  /// Subclasses must override this to provide type-specific decoding.
  /// Use the parsing utilities to extract field strings, then recursively
  /// call fromYaml on each value.
  static MapObject<TreeObject> fromYaml(String yaml) {
    throw UnimplementedError('fromYaml must be implemented by subclasses');
  }
}
