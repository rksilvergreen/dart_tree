import 'dart:collection';
import 'tree_object.dart';
import '../syntax/json_formatting.dart';
import '../syntax/yaml_formatting.dart';

/// Base class for list-like collection objects.
///
/// Provides List interface for accessing child objects by index.
/// User-defined list collection objects will extend this class.
///
/// Example:
/// ```dart
/// @treeObject
/// class ParametersList extends ListObject<Parameter> {
///   ParametersList(super.elements);
/// }
/// ```
abstract class ListObject<CHILD_OBJECT extends TreeObject> extends TreeObject with ListMixin<CHILD_OBJECT> {
  /// The internal list storage.
  final List<CHILD_OBJECT> _elements;

  /// JSON-specific list/array styling.
  final JsonArrayStyle? jsonArrayStyle;

  /// YAML-specific sequence styling.
  final YamlSequenceStyle? yamlSequenceStyle;

  ListObject(
    List<CHILD_OBJECT> elements, {
    super.sourceRange,
    super.jsonFormatting,
    super.yamlFormatting,
    this.jsonArrayStyle,
    this.yamlSequenceStyle,
  }) : _elements = elements;

  @override
  int get length => _elements.length;

  @override
  set length(int newLength) => _elements.length = newLength;

  @override
  CHILD_OBJECT operator [](int index) => _elements[index];

  @override
  void operator []=(int index, CHILD_OBJECT value) => _elements[index] = value;

  @override
  String toJson({String indent = '  ', bool prettyPrint = true}) {
    final singleLine = jsonArrayStyle?.singleLine ?? !prettyPrint;
    final buffer = StringBuffer();

    // Opening bracket with whitespace
    if (jsonArrayStyle?.whitespaceBefore != null) {
      buffer.write(jsonArrayStyle!.whitespaceBefore);
    }
    buffer.write('[');
    if (jsonArrayStyle?.whitespaceAfterOpen != null) {
      buffer.write(jsonArrayStyle!.whitespaceAfterOpen);
    } else if (!singleLine) {
      buffer.writeln();
    }

    // Elements
    for (int i = 0; i < length; i++) {
      if (!singleLine) {
        buffer.write(indent);
      }
      buffer.write(this[i].toJson());
      if (i < length - 1) {
        buffer.write(',');
        if (singleLine) {
          buffer.write(' ');
        } else {
          buffer.writeln();
        }
      }
    }

    // Closing bracket with whitespace
    if (!singleLine) {
      buffer.writeln();
    }
    if (jsonArrayStyle?.whitespaceBeforeClose != null) {
      buffer.write(jsonArrayStyle!.whitespaceBeforeClose);
    }
    buffer.write(']');
    if (jsonArrayStyle?.whitespaceAfter != null) {
      buffer.write(jsonArrayStyle!.whitespaceAfter);
    }

    return buffer.toString();
  }

  @override
  String toYaml({String indent = '  '}) {
    final isFlow = yamlSequenceStyle?.style == YamlCollectionStyle.flow;
    final buffer = StringBuffer();

    if (isFlow) {
      // Flow style: [item1, item2, item3]
      buffer.write('[');
      for (int i = 0; i < length; i++) {
        buffer.write(this[i].toYaml());
        if (i < length - 1) {
          buffer.write(', ');
        }
      }
      buffer.write(']');
    } else {
      // Block style
      for (int i = 0; i < length; i++) {
        buffer.write('- ');
        buffer.write(this[i].toYaml());
        if (i < length - 1) {
          buffer.writeln();
        }
      }
    }

    return buffer.toString();
  }

  /// Parses a JSON array string to a ListObject.
  ///
  /// Input should be the full array string, e.g., `"[1, 2, 3]"`
  ///
  /// Subclasses must override this to provide type-specific decoding.
  /// Use the parsing utilities to extract element strings, then recursively
  /// call fromJson on each element.
  static ListObject<TreeObject> fromJson(String json) {
    throw UnimplementedError('fromJson must be implemented by subclasses');
  }

  /// Parses a YAML sequence string to a ListObject.
  ///
  /// Input can be flow style `"[1, 2, 3]"` or block style with `-` markers
  ///
  /// Subclasses must override this to provide type-specific decoding.
  /// Use the parsing utilities to extract element strings, then recursively
  /// call fromYaml on each element.
  static ListObject<TreeObject> fromYaml(String yaml) {
    throw UnimplementedError('fromYaml must be implemented by subclasses');
  }
}
