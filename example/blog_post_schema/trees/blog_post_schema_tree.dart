// GENERATED CODE - DO NOT MODIFY BY HAND
// Generated from blog_post_schema.dart

import 'package:dart_tree/dart_tree.dart';
import '../objects/comment_object.dart';
import '../objects/user_object.dart';
import '../objects/blog_post_object.dart';
import '../objects/admin_object.dart';
import '../objects/person_object.dart';
import '../objects/reference_object.dart';
import '../objects/ref_object.dart';
import '../nodes/comment_node.dart';
import '../nodes/user_node.dart';
import '../nodes/blog_post_node.dart';
import '../nodes/admin_node.dart';
import '../nodes/person_node.dart';
import '../nodes/reference_node.dart';
import '../nodes/ref_node.dart';

/// Generated Tree class for blog_post_schema schemas.
class BlogPostSchemaTree extends Tree {
  BlogPostSchemaTree({required super.root});

  @override
  (TreeNode, List<(Edge, Object)>)? objectToNode(Object object) {
    // Handle value objects
    if (object is StringValue) return (StringValueNode(object.value, jsonStringStyle: object.jsonStringStyle, yamlStringStyle: object.yamlStringStyle), []);
    if (object is IntValue) return (IntValueNode(object.value, jsonNumberStyle: object.jsonNumberStyle, yamlNumberStyle: object.yamlNumberStyle), []);
    if (object is DoubleValue) return (DoubleValueNode(object.value, jsonNumberStyle: object.jsonNumberStyle, yamlNumberStyle: object.yamlNumberStyle), []);
    if (object is BoolValue) return (BoolValueNode(object.value, yamlBoolStyle: object.yamlBoolStyle), []);
    if (object is NullValue) return (NullValueNode(yamlNullStyle: object.yamlNullStyle), []);

    // Handle generated objects
    if (object is CommentObject) {
      final edges = <(Edge, Object)>[];
      edges.add((Edge(StringValueNode, 'content'), object.content));
      if (object.index != null) {
        edges.add((Edge(IntValueNode, 'index'), object.index!));
      }
      if (object.buffer != null) {
        edges.add((Edge(StringValueNode, 'buffer'), object.buffer!));
      }
      return (CommentNode(), edges);
    }

    if (object is UserObject) {
      final edges = <(Edge, Object)>[];
      edges.add((Edge(StringValueNode, 'name'), object.name));
      edges.add((Edge(StringValueNode, 'email'), object.email));
      return (UserNode(), edges);
    }

    if (object is BlogPostObject) {
      final edges = <(Edge, Object)>[];
      edges.add((Edge(StringValueNode, 'title'), object.title));
      if (object.author != null) {
        edges.add((Edge(StringValueNode, 'author'), object.author!));
      }
      edges.add((Edge(StringValueNode, 'content'), object.content));
      if (object.comments != null) {
        edges.add((Edge(ListTreeNode, 'comments'), object.comments!));
      }
      if (object.user != null) {
        edges.add((Edge(UserNode, 'user'), object.user!));
      }
      return (BlogPostNode(), edges);
    }

    if (object is AdminObject) {
      final edges = <(Edge, Object)>[];
      edges.add((Edge(IntValueNode, 'age'), object.age));
      edges.add((Edge(StringValueNode, 'address'), object.address));
      return (AdminNode(), edges);
    }

    if (object is ReferenceObject) {
      final edges = <(Edge, Object)>[];
      if (object.$ref != null) {
        edges.add((Edge(StringValueNode, '\$ref'), object.$ref!));
      }
      return (ReferenceNode(), edges);
    }

    return null;
  }
}
