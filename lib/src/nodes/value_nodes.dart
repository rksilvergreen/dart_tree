import 'tree_node.dart';
import '../objects/value_objects.dart';

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

  ValueNode(this.valueObject, {String? id}) : super(id: id);

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
  StringValueNode(super.valueObject, {super.id});

  @override
  StringValueNode clone() => StringValueNode(valueObject);

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
  IntValueNode(super.valueObject, {super.id});

  @override
  IntValueNode clone() => IntValueNode(valueObject);

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
  DoubleValueNode(super.valueObject, {super.id});

  @override
  DoubleValueNode clone() => DoubleValueNode(valueObject);

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
  BoolValueNode(super.valueObject, {super.id});

  @override
  BoolValueNode clone() => BoolValueNode(valueObject);

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
  NullValueNode(super.valueObject, {super.id});

  @override
  NullValueNode clone() => NullValueNode(valueObject);

  @override
  T accept<T>(TreeNodeVisitor<T> visitor) => visitor.visitNode(this);

  @override
  String toString() => 'NullValueNode(null)';
}
