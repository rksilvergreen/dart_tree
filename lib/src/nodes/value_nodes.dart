import 'tree_node.dart';
import '../objects/value_objects.dart';
import '../syntax/source_position.dart';
import '../syntax/json_formatting.dart';
import '../syntax/yaml_formatting.dart';

/// Base class for value nodes that correspond to ValueObject instances.
///
/// ValueNodes hold a reference to their original ValueObject, so all formatting
/// and style information can be accessed through [valueObject].
abstract class ValueNode<T, O extends ValueObject<T>> extends TreeNode {
  /// Reference to the original value object.
  ///
  /// All type-specific styling (e.g., JsonStringStyle, YamlNumberStyle) is
  /// accessed through this reference.
  final O valueObject;

  ValueNode(
    this.valueObject, {
    String? id,
    SourceRange? sourceRange,
    JsonFormattingInfo? jsonFormatting,
    YamlFormattingInfo? yamlFormatting,
  }) : super(
          id: id,
          sourceRange: sourceRange ?? valueObject.sourceRange,
          jsonFormatting: jsonFormatting ?? valueObject.jsonFormatting,
          yamlFormatting: yamlFormatting ?? valueObject.yamlFormatting,
        );

  /// The semantic value.
  T get value => valueObject.value;

  @override
  ValueNode<T, O> clone();
}

/// String value node corresponding to StringValue.
///
/// Access JSON/YAML string styling via [valueObject.jsonStringStyle] and
/// [valueObject.yamlStringStyle].
class StringValueNode extends ValueNode<String, StringValue> {
  StringValueNode(super.valueObject, {super.id, super.sourceRange, super.jsonFormatting, super.yamlFormatting});

  @override
  StringValueNode clone() => StringValueNode(
        valueObject,
        sourceRange: sourceRange,
        jsonFormatting: jsonFormatting,
        yamlFormatting: yamlFormatting,
      );

  @override
  T accept<T>(TreeNodeVisitor<T> visitor) => visitor.visitNode(this);

  @override
  String toString() => 'StringValueNode("$value")';
}

/// Integer value node corresponding to IntValue.
///
/// Access JSON/YAML number styling via [valueObject.jsonNumberStyle] and
/// [valueObject.yamlNumberStyle].
class IntValueNode extends ValueNode<int, IntValue> {
  IntValueNode(super.valueObject, {super.id, super.sourceRange, super.jsonFormatting, super.yamlFormatting});

  @override
  IntValueNode clone() => IntValueNode(
        valueObject,
        sourceRange: sourceRange,
        jsonFormatting: jsonFormatting,
        yamlFormatting: yamlFormatting,
      );

  @override
  T accept<T>(TreeNodeVisitor<T> visitor) => visitor.visitNode(this);

  @override
  String toString() => 'IntValueNode($value)';
}

/// Double value node corresponding to DoubleValue.
///
/// Access JSON/YAML number styling via [valueObject.jsonNumberStyle] and
/// [valueObject.yamlNumberStyle].
class DoubleValueNode extends ValueNode<double, DoubleValue> {
  DoubleValueNode(super.valueObject, {super.id, super.sourceRange, super.jsonFormatting, super.yamlFormatting});

  @override
  DoubleValueNode clone() => DoubleValueNode(
        valueObject,
        sourceRange: sourceRange,
        jsonFormatting: jsonFormatting,
        yamlFormatting: yamlFormatting,
      );

  @override
  T accept<T>(TreeNodeVisitor<T> visitor) => visitor.visitNode(this);

  @override
  String toString() => 'DoubleValueNode($value)';
}

/// Boolean value node corresponding to BoolValue.
///
/// Access YAML bool styling via [valueObject.yamlBoolStyle].
/// JSON booleans are always "true" or "false".
class BoolValueNode extends ValueNode<bool, BoolValue> {
  BoolValueNode(super.valueObject, {super.id, super.sourceRange, super.jsonFormatting, super.yamlFormatting});

  @override
  BoolValueNode clone() => BoolValueNode(
        valueObject,
        sourceRange: sourceRange,
        jsonFormatting: jsonFormatting,
        yamlFormatting: yamlFormatting,
      );

  @override
  T accept<T>(TreeNodeVisitor<T> visitor) => visitor.visitNode(this);

  @override
  String toString() => 'BoolValueNode($value)';
}

/// Null value node corresponding to NullValue.
///
/// Access YAML null styling via [valueObject.yamlNullStyle].
/// JSON null is always "null".
class NullValueNode extends ValueNode<Null, NullValue> {
  NullValueNode(super.valueObject, {super.id, super.sourceRange, super.jsonFormatting, super.yamlFormatting});

  @override
  NullValueNode clone() => NullValueNode(
        valueObject,
        sourceRange: sourceRange,
        jsonFormatting: jsonFormatting,
        yamlFormatting: yamlFormatting,
      );

  @override
  T accept<T>(TreeNodeVisitor<T> visitor) => visitor.visitNode(this);

  @override
  String toString() => 'NullValueNode(null)';
}

