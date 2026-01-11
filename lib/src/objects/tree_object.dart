import '../syntax/source_position.dart';
import '../syntax/json_formatting.dart';
import '../syntax/yaml_formatting.dart';

/// Base class for all user-defined domain objects.
///
/// Users extend this class to create their domain model. The code generator
/// will create corresponding TreeNode classes and conversion logic.
///
/// Example:
/// ```dart
/// @treeObject
/// class Operation extends TreeObject {
///   final StringValue? operationId;
///   final RequestBody requestBody;
///
///   Operation({
///     this.operationId,
///     required this.requestBody,
///     super.sourceRange,
///     super.jsonFormatting,
///     super.yamlFormatting,
///   });
/// }
/// ```
abstract class TreeObject {
  /// The source range in the original file (if parsed).
  final SourceRange? sourceRange;

  /// JSON-specific formatting information.
  final JsonFormattingInfo? jsonFormatting;

  /// YAML-specific formatting information.
  final YamlFormattingInfo? yamlFormatting;

  const TreeObject({this.sourceRange, this.jsonFormatting, this.yamlFormatting});

  /// Encodes this object to a JSON string.
  /// 
  /// All TreeObject subclasses must implement this method to provide
  /// JSON serialization with formatting metadata applied.
  String toJson();

  /// Encodes this object to a YAML string.
  /// 
  /// All TreeObject subclasses must implement this method to provide
  /// YAML serialization with formatting metadata applied.
  String toYaml();

  /// Decodes a JSON value to a TreeObject.
  /// 
  /// All TreeObject subclasses must provide a static factory method
  /// to decode from JSON (typically via code generation).
  /// 
  /// Note: This is declared here for documentation purposes.
  /// Dart doesn't support abstract static methods, so implementations
  /// should provide: `static T fromJson(dynamic json)`
  static Never fromJson(dynamic json) {
    throw UnsupportedError('fromJson must be implemented as a static method in subclasses');
  }

  /// Decodes a YAML value to a TreeObject.
  /// 
  /// All TreeObject subclasses must provide a static factory method
  /// to decode from YAML (typically via code generation).
  /// 
  /// Note: This is declared here for documentation purposes.
  /// Dart doesn't support abstract static methods, so implementations
  /// should provide: `static T fromYaml(dynamic yaml)`
  static Never fromYaml(dynamic yaml) {
    throw UnsupportedError('fromYaml must be implemented as a static method in subclasses');
  }
}
