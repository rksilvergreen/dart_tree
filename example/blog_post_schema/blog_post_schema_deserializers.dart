// GENERATED CODE - DO NOT MODIFY BY HAND
// Generated from blog_post_schema.dart

import 'package:dart_tree/dart_tree.dart';
import 'objects/user_object.dart';
import 'objects/admin_object.dart';
import 'objects/comment_object.dart';
import 'objects/blog_post_object.dart';
import 'objects/reference_object.dart';

/// Generic fromJson function that dispatches to the correct type.
T fromJson<T extends TreeObject>(String json) {
  if (T == UserObject) return UserObject.fromJson(json) as T;
  if (T == AdminObject) return AdminObject.fromJson(json) as T;
  if (T == CommentObject) return CommentObject.fromJson(json) as T;
  if (T == BlogPostObject) return BlogPostObject.fromJson(json) as T;
  if (T == ReferenceObject) return ReferenceObject.fromJson(json) as T;
  throw UnsupportedError('Type $T is not supported for fromJson in this schema');
}

/// Generic fromYaml function that dispatches to the correct type.
T fromYaml<T extends TreeObject>(String yaml) {
  if (T == UserObject) return UserObject.fromYaml(yaml) as T;
  if (T == AdminObject) return AdminObject.fromYaml(yaml) as T;
  if (T == CommentObject) return CommentObject.fromYaml(yaml) as T;
  if (T == BlogPostObject) return BlogPostObject.fromYaml(yaml) as T;
  if (T == ReferenceObject) return ReferenceObject.fromYaml(yaml) as T;
  throw UnsupportedError('Type $T is not supported for fromYaml in this schema');
}
