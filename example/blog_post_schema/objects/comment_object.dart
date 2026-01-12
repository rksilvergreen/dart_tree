// GENERATED CODE - DO NOT MODIFY BY HAND
// Generated from blog_post_schema.dart

import 'package:dart_tree/dart_tree.dart';

/// Generated TreeObject class for Comment
class CommentObject extends TreeObject {
  final StringValue content;

  CommentObject({
    required this.content,
  }) {
    {if (content.value.length < 1 || content.value.length > 1000) {throw ArgumentError('content must be 1-1000 characters');}}
  }

  @override
  String toJson() {
    return '{"${'content'}": ' + content.toJson() + '}';
  }

  @override
  String toYaml() {
    return 'content: ' + content.toYaml();
  }

  static CommentObject fromJson(String json) {
    final map = extractJsonObjectFields(json);
    return $checkedCreate(
      'CommentObject',
      map,
      ($checkedConvert) {
        $checkKeys(
          map,
          requiredKeys: const ['content'],
        );
        final val = CommentObject(
          content: $checkedConvert('content', (v) => StringValue.fromJson(v as String)),
        );
        return val;
      },
    );
  }

  static CommentObject fromYaml(String yaml) {
    final map = extractYamlMappingFields(yaml);
    return $checkedCreate(
      'CommentObject',
      map,
      ($checkedConvert) {
        $checkKeys(
          map,
          requiredKeys: const ['content'],
        );
        final val = CommentObject(
          content: $checkedConvert('content', (v) => StringValue.fromYaml(v as String)),
        );
        return val;
      },
    );
  }
}
