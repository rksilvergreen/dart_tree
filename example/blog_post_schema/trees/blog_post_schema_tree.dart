// GENERATED CODE - DO NOT MODIFY BY HAND
// Generated from blog_post_schema.dart

import 'package:dart_tree/dart_tree.dart';
import '../objects/user_object.dart';
import '../objects/admin_object.dart';
import '../objects/person_object.dart';
import '../objects/comment_object.dart';
import '../objects/blog_post_object.dart';
import '../objects/reference_object.dart';
import '../objects/ref_object.dart';
import '../nodes/user_node.dart';
import '../nodes/admin_node.dart';
import '../nodes/person_node.dart';
import '../nodes/comment_node.dart';
import '../nodes/blog_post_node.dart';
import '../nodes/reference_node.dart';
import '../nodes/ref_node.dart';

/// Generated Tree class for blog_post_schema schemas.
class BlogPostSchemaTree extends Tree {
  BlogPostSchemaTree({required super.root});

  @override
  void fromObject<T extends TreeObject>(TreeObject object) {
    // Handle value objects
    if (object is StringValue) { StringValueNode.fromObject(this, null, '', object); return; }
    if (object is IntValue) { IntValueNode.fromObject(this, null, '', object); return; }
    if (object is DoubleValue) { DoubleValueNode.fromObject(this, null, '', object); return; }
    if (object is BoolValue) { BoolValueNode.fromObject(this, null, '', object); return; }
    if (object is NullValue) { NullValueNode.fromObject(this, null, '', object); return; }

    // Handle union objects - delegate to concrete type
    if (object is PersonObject) {
      if (object.isUser) { fromObject(object.asUser!); return; }
      else if (object.isAdmin) { fromObject(object.asAdmin!); return; }
      return;
    }

    if (object is RefObject) {
      if (object.isReference) { fromObject(object.asReference!); return; }
      else if (object.isValue) { fromObject(object.asValue!); return; }
      return;
    }

    // Handle generated objects
    if (object is UserObject) {
      UserNode.fromObject(this, null, '', object);
      return;
    }

    if (object is AdminObject) {
      AdminNode.fromObject(this, null, '', object);
      return;
    }

    if (object is CommentObject) {
      CommentNode.fromObject(this, null, '', object);
      return;
    }

    if (object is BlogPostObject) {
      BlogPostNode.fromObject(this, null, '', object);
      return;
    }

    if (object is ReferenceObject) {
      ReferenceNode.fromObject(this, null, '', object);
      return;
    }

  }
}
