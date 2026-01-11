import 'value_objects.dart';
import 'union_objects.dart';


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
///   });
/// }
/// ```
abstract class TreeObject {
  const TreeObject();

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

  // static T fromJson<T extends TreeObject>(dynamic json) {
  //   late final T object;
  //   if (T == StringValue) {
  //     object = StringValue.fromJson(json) as T;
  //   } else if (T == IntValue) {
  //     object = IntValue.fromJson(json) as T;
  //   } else if (T == DoubleValue) {
  //     object = DoubleValue.fromJson(json) as T;
  //   } else if (T == BoolValue) {
  //     object = BoolValue.fromJson(json) as T;
  //   } else if (T == NullValue) {
  //     object = NullValue.fromJson(json) as T;
  //   }
  //   return object;
  // }

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
