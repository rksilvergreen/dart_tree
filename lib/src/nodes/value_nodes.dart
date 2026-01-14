import 'tree_node.dart';
import '../syntax/json_formatting.dart';
import '../syntax/yaml_formatting.dart';
import '../tree.dart';
import '../tree_node_record.dart';
import '../edge.dart';
import '../utils/pointer.dart';
import '../objects/value_objects.dart';

/// String value node.
///
/// Holds the same properties as StringValue for lossless round-tripping.
class StringValueNode extends TreeNode {
  /// The semantic value.
  final String value;

  /// JSON-specific string styling (quote style, escape sequences, etc.).
  final JsonStringStyle? jsonStringStyle;

  /// YAML-specific string styling (quote style, block scalars, etc.).
  final YamlStringStyle? yamlStringStyle;

  StringValueNode(this.value, {this.jsonStringStyle, this.yamlStringStyle, super.id});

  static void fromObject(Tree tree, TreeNode? parent, String key, StringValue object) {
    final parentRecord = tree.nodes[parent?.id];
    final pointer = Pointer.build(parentRecord?.pointer, key);
    final node = StringValueNode(
      object.value,
      jsonStringStyle: object.jsonStringStyle,
      yamlStringStyle: object.yamlStringStyle,
    );
    tree.$nodes[node.id] = TreeNodeRecord(node: node, pointer: pointer, parent: parent?.id);
    parentRecord?.children[Edge(StringValueNode, key)] = node.id;
  }

  @override
  StringValueNode clone() => StringValueNode(value, jsonStringStyle: jsonStringStyle, yamlStringStyle: yamlStringStyle);

  @override
  T accept<T>(TreeNodeVisitor<T> visitor) => visitor.visitNode(this);

  @override
  String toString() => 'StringValueNode("$value")';
}

/// Integer value node.
///
/// Holds the same properties as IntValue for lossless round-tripping.
class IntValueNode extends TreeNode {
  /// The semantic value.
  final int value;

  /// JSON-specific number styling (decimal vs scientific notation, etc.).
  final JsonNumberStyle? jsonNumberStyle;

  /// YAML-specific number styling (hex, octal, binary, etc.).
  final YamlNumberStyle? yamlNumberStyle;

  IntValueNode(this.value, {this.jsonNumberStyle, this.yamlNumberStyle, super.id});

  static void fromObject(Tree tree, TreeNode? parent, String key, IntValue object) {
    final parentRecord = tree.nodes[parent?.id];
    final pointer = Pointer.build(parentRecord?.pointer, key);
    final node = IntValueNode(
      object.value,
      jsonNumberStyle: object.jsonNumberStyle,
      yamlNumberStyle: object.yamlNumberStyle,
    );
    tree.$nodes[node.id] = TreeNodeRecord(node: node, pointer: pointer, parent: parent?.id);
    parentRecord?.children[Edge(IntValueNode, key)] = node.id;
  }

  @override
  IntValueNode clone() => IntValueNode(value, jsonNumberStyle: jsonNumberStyle, yamlNumberStyle: yamlNumberStyle);

  @override
  T accept<T>(TreeNodeVisitor<T> visitor) => visitor.visitNode(this);

  @override
  String toString() => 'IntValueNode($value)';
}

/// Double value node.
///
/// Holds the same properties as DoubleValue for lossless round-tripping.
class DoubleValueNode extends TreeNode {
  /// The semantic value.
  final double value;

  /// JSON-specific number styling (decimal places, scientific notation, etc.).
  final JsonNumberStyle? jsonNumberStyle;

  /// YAML-specific number styling (special floats like .inf, .nan, etc.).
  final YamlNumberStyle? yamlNumberStyle;

  DoubleValueNode(this.value, {this.jsonNumberStyle, this.yamlNumberStyle, super.id});

  static void fromObject(Tree tree, TreeNode? parent, String key, DoubleValue object) {
    final parentRecord = tree.nodes[parent?.id];
    final pointer = Pointer.build(parentRecord?.pointer, key);
    final node = DoubleValueNode(
      object.value,
      jsonNumberStyle: object.jsonNumberStyle,
      yamlNumberStyle: object.yamlNumberStyle,
    );
    tree.$nodes[node.id] = TreeNodeRecord(node: node, pointer: pointer, parent: parent?.id);
    parentRecord?.children[Edge(DoubleValueNode, key)] = node.id;
  }

  @override
  DoubleValueNode clone() => DoubleValueNode(value, jsonNumberStyle: jsonNumberStyle, yamlNumberStyle: yamlNumberStyle);

  @override
  T accept<T>(TreeNodeVisitor<T> visitor) => visitor.visitNode(this);

  @override
  String toString() => 'DoubleValueNode($value)';
}

/// Boolean value node.
///
/// Holds the same properties as BoolValue for lossless round-tripping.
class BoolValueNode extends TreeNode {
  /// The semantic value.
  final bool value;

  /// YAML-specific bool styling (true/yes/on, false/no/off variations).
  final YamlBoolStyle? yamlBoolStyle;

  BoolValueNode(this.value, {this.yamlBoolStyle, super.id});

  static void fromObject(Tree tree, TreeNode? parent, String key, BoolValue object) {
    final parentRecord = tree.nodes[parent?.id];
    final pointer = Pointer.build(parentRecord?.pointer, key);
    final node = BoolValueNode(object.value, yamlBoolStyle: object.yamlBoolStyle);
    tree.$nodes[node.id] = TreeNodeRecord(node: node, pointer: pointer, parent: parent?.id);
    parentRecord?.children[Edge(BoolValueNode, key)] = node.id;
  }

  @override
  BoolValueNode clone() => BoolValueNode(value, yamlBoolStyle: yamlBoolStyle);

  @override
  T accept<T>(TreeNodeVisitor<T> visitor) => visitor.visitNode(this);

  @override
  String toString() => 'BoolValueNode($value)';
}

/// Null value node.
///
/// Holds the same properties as NullValue for lossless round-tripping.
class NullValueNode extends TreeNode {
  /// YAML-specific null styling (null/~/empty variations).
  final YamlNullStyle? yamlNullStyle;

  NullValueNode({this.yamlNullStyle, super.id});

  static void fromObject(Tree tree, TreeNode? parent, String key, NullValue object) {
    final parentRecord = tree.nodes[parent?.id];
    final pointer = Pointer.build(parentRecord?.pointer, key);
    final node = NullValueNode(yamlNullStyle: object.yamlNullStyle);
    tree.$nodes[node.id] = TreeNodeRecord(node: node, pointer: pointer, parent: parent?.id);
    parentRecord?.children[Edge(NullValueNode, key)] = node.id;
  }

  @override
  NullValueNode clone() => NullValueNode(yamlNullStyle: yamlNullStyle);

  @override
  T accept<T>(TreeNodeVisitor<T> visitor) => visitor.visitNode(this);

  @override
  String toString() => 'NullValueNode(null)';
}
