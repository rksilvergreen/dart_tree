import 'dart:collection';
import '../syntax/json_formatting.dart';
import '../syntax/yaml_formatting.dart';

abstract class SyntaxObject with MapMixin<String, dynamic> {
  /// The internal map storage.
  final Map<String, dynamic> _entries;

  /// JSON-specific object styling.
  final JsonObjectStyle? jsonObjectStyle;

  /// YAML-specific mapping styling.
  final YamlMappingStyle? yamlMappingStyle;

  SyntaxObject(Map<String, dynamic> entries, {this.jsonObjectStyle, this.yamlMappingStyle}) : _entries = entries;

  @override
  dynamic operator [](Object? key) => _entries[key];

  @override
  void operator []=(String key, dynamic value) => _entries[key] = value;

  @override
  void clear() => _entries.clear();

  @override
  dynamic remove(Object? key) => _entries.remove(key);

  @override
  Iterable<String> get keys => _entries.keys;

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
}
