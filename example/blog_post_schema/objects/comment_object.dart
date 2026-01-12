// GENERATED CODE - DO NOT MODIFY BY HAND
// Generated from blog_post_schema.dart

import 'package:dart_tree/dart_tree.dart';

/// Generated TreeObject class for Comment
class CommentObject extends TreeObject {
  final StringValue content;
  final IntValue? index;
  final StringValue? buffer;

  CommentObject({
    required this.content,
    this.index,
    this.buffer,
  }) {
    {if (content.value.length < 1 || content.value.length > 1000) {throw ArgumentError('content must be 1-1000 characters');}}
  }

  @override
  String toJson() {
    final buffer = StringBuffer();
    buffer.write('{');
    buffer.write('"content": ');
    buffer.write(this.content.toJson());
    if (this.index != null) {
      buffer.write(', ');
      buffer.write('"index": ');
      buffer.write(this.index!.toJson());
    }
    if (this.buffer != null) {
      buffer.write(', ');
      buffer.write('"buffer": ');
      buffer.write(this.buffer!.toJson());
    }
    buffer.write('}');
    return buffer.toString();
  }

  @override
  String toYaml() {
    final buffer = StringBuffer();
    buffer.write('content: ');
    buffer.write(this.content.toYaml());
    if (this.index != null) {
      buffer.writeln();
      buffer.write('index: ');
      buffer.write(this.index!.toYaml());
    }
    if (this.buffer != null) {
      buffer.writeln();
      buffer.write('buffer: ');
      buffer.write(this.buffer!.toYaml());
    }
    return buffer.toString();
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
          index: $checkedConvert('index', (v) => v == null ? null : IntValue.fromJson(v as String)),
          buffer: $checkedConvert('buffer', (v) => v == null ? null : StringValue.fromJson(v as String)),
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
          index: $checkedConvert('index', (v) => v == null ? null : IntValue.fromYaml(v as String)),
          buffer: $checkedConvert('buffer', (v) => v == null ? null : StringValue.fromYaml(v as String)),
        );
        return val;
      },
    );
  }
}
