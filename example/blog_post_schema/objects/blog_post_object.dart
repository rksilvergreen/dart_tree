// GENERATED CODE - DO NOT MODIFY BY HAND
// Generated from blog_post_schema.dart

import 'package:dart_tree/dart_tree.dart';
import '../blog_post_schema_deserializers.dart';
import 'comment_object.dart';
import 'user_object.dart';
import 'book_object.dart';
import 'admin_object.dart';
import 'reference_object.dart';

/// Generated TreeObject class for BlogPost
class BlogPostObject extends TreeObject {
  final StringValue title;
  final StringValue? author;
  final StringValue content;
  final CommentsListObject? comments;
  final UserObject? user;
  final BookObject<ReferencesListObject, AdminObject>? book;
  final ReferencesListObject? library;

  BlogPostObject({
    required this.title,
    this.author,
    required this.content,
    this.comments,
    this.user,
    this.book,
    this.library,
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
    if (this.user != null) {
      buffer.write(', ');
      buffer.write('"user": ');
      buffer.write(this.user!.toJson());
    }
    if (this.book != null) {
      buffer.write(', ');
      buffer.write('"book": ');
      buffer.write(this.book!.toJson());
    }
    if (this.library != null) {
      buffer.write(', ');
      buffer.write('"library": ');
      buffer.write(this.library!.toJson());
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
    if (this.user != null) {
      buffer.writeln();
      buffer.write('user: ');
      buffer.write(this.user!.toYaml());
    }
    if (this.book != null) {
      buffer.writeln();
      buffer.write('book: ');
      buffer.write(this.book!.toYaml());
    }
    if (this.library != null) {
      buffer.writeln();
      buffer.write('library: ');
      buffer.write(this.library!.toYaml());
    }
    return buffer.toString();
  }

  static BlogPostObject fromJson(String json) {
    final map = extractJsonObjectFields(json);
    return $checkedCreate('BlogPostObject', map, ($checkedConvert) {
      $checkKeys(
        map,
        allowedKeys: const ['title', 'author', 'content', 'comments', 'user'],
        requiredKeys: const ['title', 'content'],
      );
      final val = BlogPostObject(
        title: $checkedConvert('title', (v) => StringValue.fromJson(v as String)),
        author: $checkedConvert('author', (v) => v == null ? null : StringValue.fromJson(v as String)),
        content: $checkedConvert('content', (v) => StringValue.fromJson(v as String)),
        comments: $checkedConvert(
          'comments',
          (v) => v == null
              ? null
              : CommentsListObject(
                  extractJsonArrayElements(v as String).map((item) => CommentObject.fromJson(item)).toList(),
                ),
        ),
        user: $checkedConvert('user', (v) => v == null ? null : UserObject.fromJson(v as String)),
        book: $checkedConvert(
          'book',
          (v) => v == null
              ? null
              : BookObject.fromJson<ReferencesListObject, AdminObject>(
                  v as String,
                  (String s) => ReferencesListObject(
                    extractJsonArrayElements(s).map((item) => ReferenceObject.fromJson(item)).toList(),
                  ),
                  (String s) => AdminObject.fromJson(s),
                ),
        ),
        library: $checkedConvert(
          'library',
          (v) => v == null
              ? null
              : ReferencesListObject(
                  extractJsonArrayElements(v as String).map((item) => ReferenceObject.fromJson(item)).toList(),
                ),
        ),
      );
      return val;
    });
  }

  static BlogPostObject fromYaml(String yaml) {
    final map = extractYamlMappingFields(yaml);
    return $checkedCreate('BlogPostObject', map, ($checkedConvert) {
      $checkKeys(
        map,
        allowedKeys: const ['title', 'author', 'content', 'comments', 'user'],
        requiredKeys: const ['title', 'content'],
      );
      final val = BlogPostObject(
        title: $checkedConvert('title', (v) => StringValue.fromYaml(v as String)),
        author: $checkedConvert('author', (v) => v == null ? null : StringValue.fromYaml(v as String)),
        content: $checkedConvert('content', (v) => StringValue.fromYaml(v as String)),
        comments: $checkedConvert(
          'comments',
          (v) => v == null
              ? null
              : CommentsListObject(
                  extractYamlSequenceElements(v as String).map((item) => CommentObject.fromYaml(item)).toList(),
                ),
        ),
        user: $checkedConvert('user', (v) => v == null ? null : UserObject.fromYaml(v as String)),
        book: $checkedConvert(
          'book',
          (v) => v == null
              ? null
              : BookObject.fromYaml<ReferencesListObject, AdminObject>(
                  v as String,
                  (String s) => ReferencesListObject(
                    extractYamlSequenceElements(s).map((item) => ReferenceObject.fromYaml(item)).toList(),
                  ),
                  (String s) => AdminObject.fromYaml(s),
                ),
        ),
        library: $checkedConvert(
          'library',
          (v) => v == null
              ? null
              : ReferencesListObject(
                  extractYamlSequenceElements(v as String).map((item) => ReferenceObject.fromYaml(item)).toList(),
                ),
        ),
      );
      return val;
    });
  }
}
