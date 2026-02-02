// GENERATED CODE - DO NOT MODIFY BY HAND
// Generated from blog_post_schema.dart

import 'package:dart_tree/dart_tree.dart';
import '../blog_post_schema_deserializers.dart';
import 'person_object.dart';
import 'ref_object.dart';
import 'admin_object.dart';

/// Generated TreeObject class for Comment
class CommentObject extends TreeObject {
  final StringValue content;
  final IntValue? index;
  final StringValue? buffer;
  final PersonObject? person;
  final RefObject<AdminObject>? ref;

  CommentObject({
    required this.content,
    this.index,
    this.buffer,
    this.person,
    this.ref,
  });

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
    if (this.person != null) {
      buffer.write(', ');
      buffer.write('"person": ');
      buffer.write(this.person!.toJson());
    }
    if (this.ref != null) {
      buffer.write(', ');
      buffer.write('"ref": ');
      buffer.write(this.ref!.toJson());
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
    if (this.person != null) {
      buffer.writeln();
      buffer.write('person: ');
      buffer.write(this.person!.toYaml());
    }
    if (this.ref != null) {
      buffer.writeln();
      buffer.write('ref: ');
      buffer.write(this.ref!.toYaml());
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
          person: $checkedConvert('person', (v) => v == null ? null : PersonObject.fromJson(v as String)),
          ref: $checkedConvert('ref', (v) => v == null ? null : RefObject.fromJson<AdminObject>(v as String, (String s) => AdminObject.fromJson(s))),
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
          person: $checkedConvert('person', (v) => v == null ? null : PersonObject.fromYaml(v as String)),
          ref: $checkedConvert('ref', (v) => v == null ? null : RefObject.fromYaml<AdminObject>(v as String, (String s) => AdminObject.fromYaml(s))),
        );
        return val;
      },
    );
  }
}

/// Generated ListObject for Comment
class CommentsListObject extends ListObject<CommentObject> {
  CommentsListObject(super.elements);
}
