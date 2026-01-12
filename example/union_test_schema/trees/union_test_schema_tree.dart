// GENERATED CODE - DO NOT MODIFY BY HAND
// Generated from union_test_schema.dart

import 'package:dart_tree/dart_tree.dart';
import '../objects/string_or_int_object.dart';
import '../objects/mixed_value_object.dart';
import '../objects/config_object.dart';
import '../nodes/string_or_int_node.dart';
import '../nodes/mixed_value_node.dart';
import '../nodes/config_node.dart';

/// Generated Tree class for union_test_schema schemas.
class UnionTestSchemaTree extends Tree {
  UnionTestSchemaTree({required super.root});

  @override
  (TreeNode, List<(Edge, Object)>)? objectToNode(Object object) {
    // Handle value objects
    if (object is StringValue) return (StringValueNode(object.value, jsonStringStyle: object.jsonStringStyle, yamlStringStyle: object.yamlStringStyle), []);
    if (object is IntValue) return (IntValueNode(object.value, jsonNumberStyle: object.jsonNumberStyle, yamlNumberStyle: object.yamlNumberStyle), []);
    if (object is DoubleValue) return (DoubleValueNode(object.value, jsonNumberStyle: object.jsonNumberStyle, yamlNumberStyle: object.yamlNumberStyle), []);
    if (object is BoolValue) return (BoolValueNode(object.value, yamlBoolStyle: object.yamlBoolStyle), []);
    if (object is NullValue) return (NullValueNode(yamlNullStyle: object.yamlNullStyle), []);

    // Handle generated objects
    if (object is ConfigObject) {
      final edges = <(Edge, Object)>[];
      edges.add((Edge(StringValueNode, 'name'), object.name));
      edges.add((Edge(UnionNode2, 'port'), object.port));
      if (object.value != null) {
        edges.add((Edge(UnionNode2, 'value'), object.value!));
      }
      return (ConfigNode(), edges);
    }

    return null;
  }
}
