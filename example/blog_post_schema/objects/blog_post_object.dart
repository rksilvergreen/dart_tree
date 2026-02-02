// GENERATED CODE - DO NOT MODIFY BY HAND
// Generated from blog_post_schema.dart

import 'package:dart_tree/dart_tree.dart';
import '../blog_post_schema_deserializers.dart';
import 'comment_object.dart';
import 'user_object.dart';
import 'ref_object.dart';

/// Generated TreeObject class for BlogPost
class BlogPostObject<T extends TreeObject, U extends TreeObject> extends TreeObject {
  final StringValue title;
  final StringValue? author;
  final StringValue content;
  final CommentsListObject? comments;
  final T? extra;
  final UserObject? user;
  final RefObject<U>? champion;

  BlogPostObject({
    required this.title,
    this.author,
    required this.content,
    this.comments,
    this.extra,
    this.user,
    this.champion,
  });

  @override
  String toJson() {
    final buffer = StringBuffer();
    buffer.write('{');
    buffer.write('"title": ');
    buffer.write(this.title.toJson());
    if (this.author != null) {
      buffer.write(', ');
      buffer.write('"author": ');
      buffer.write(this.author!.toJson());
    }
    buffer.write(', ');
    buffer.write('"content": ');
    buffer.write(this.content.toJson());
    if (this.comments != null) {
      buffer.write(', ');
      buffer.write('"comments": ');
      buffer.write(this.comments!.toJson());
    }
    if (this.extra != null) {
      buffer.write(', ');
      buffer.write('"extra": ');
      buffer.write(this.extra!.toJson());
    }
    if (this.user != null) {
      buffer.write(', ');
      buffer.write('"user": ');
      buffer.write(this.user!.toJson());
    }
    if (this.champion != null) {
      buffer.write(', ');
      buffer.write('"champion": ');
      buffer.write(this.champion!.toJson());
    }
    buffer.write('}');
    return buffer.toString();
  }

  @override
  String toYaml() {
    final buffer = StringBuffer();
    buffer.write('title: ');
    buffer.write(this.title.toYaml());
    if (this.author != null) {
      buffer.writeln();
      buffer.write('author: ');
      buffer.write(this.author!.toYaml());
    }
    buffer.writeln();
    buffer.write('content: ');
    buffer.write(this.content.toYaml());
    if (this.comments != null) {
      buffer.writeln();
      buffer.write('comments: ');
      buffer.write(this.comments!.toYaml());
    }
    if (this.extra != null) {
      buffer.writeln();
      buffer.write('extra: ');
      buffer.write(this.extra!.toYaml());
    }
    if (this.user != null) {
      buffer.writeln();
      buffer.write('user: ');
      buffer.write(this.user!.toYaml());
    }
    if (this.champion != null) {
      buffer.writeln();
      buffer.write('champion: ');
      buffer.write(this.champion!.toYaml());
    }
    return buffer.toString();
  }

  static BlogPostObject<T, U> fromJson<T extends TreeObject, U extends TreeObject>(String json, Deserializer<T> deserializer_T, Deserializer<U> deserializer_U) {
    final map = extractJsonObjectFields(json);
    return $checkedCreate(
      'BlogPostObject',
      map,
      ($checkedConvert) {
        $checkKeys(
          map,
          allowedKeys: const ['title', 'author', 'content', 'comments', 'user'],
          requiredKeys: const ['title', 'content'],
        );
        final val = BlogPostObject<T, U>(
          title: $checkedConvert('title', (v) => StringValue.fromJson(v as String)),
          author: $checkedConvert('author', (v) => v == null ? null : StringValue.fromJson(v as String)),
          content: $checkedConvert('content', (v) => StringValue.fromJson(v as String)),
          comments: $checkedConvert('comments', (v) => v == null ? null : CommentsListObject(extractJsonArrayElements(v as String).map((item) => CommentObject.fromJson(item)).toList())),
          extra: $checkedConvert('extra', (v) => v == null ? null : deserializer_T(v as String)),
          user: $checkedConvert('user', (v) => v == null ? null : UserObject.fromJson(v as String)),
          champion: $checkedConvert('champion', (v) => v == null ? null : RefObject.fromJson<U>(v as String, deserializer_U)),
        );
        return val;
      },
    );
  }

  static BlogPostObject<T, U> fromYaml<T extends TreeObject, U extends TreeObject>(String yaml, Deserializer<T> deserializer_T, Deserializer<U> deserializer_U) {
    final map = extractYamlMappingFields(yaml);
    return $checkedCreate(
      'BlogPostObject',
      map,
      ($checkedConvert) {
        $checkKeys(
          map,
          allowedKeys: const ['title', 'author', 'content', 'comments', 'user'],
          requiredKeys: const ['title', 'content'],
        );
        final val = BlogPostObject<T, U>(
          title: $checkedConvert('title', (v) => StringValue.fromYaml(v as String)),
          author: $checkedConvert('author', (v) => v == null ? null : StringValue.fromYaml(v as String)),
          content: $checkedConvert('content', (v) => StringValue.fromYaml(v as String)),
          comments: $checkedConvert('comments', (v) => v == null ? null : CommentsListObject(extractYamlSequenceElements(v as String).map((item) => CommentObject.fromYaml(item)).toList())),
          extra: $checkedConvert('extra', (v) => v == null ? null : deserializer_T(v as String)),
          user: $checkedConvert('user', (v) => v == null ? null : UserObject.fromYaml(v as String)),
          champion: $checkedConvert('champion', (v) => v == null ? null : RefObject.fromYaml<U>(v as String, deserializer_U)),
        );
        return val;
      },
    );
  }
}
