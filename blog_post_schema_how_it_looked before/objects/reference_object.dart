// GENERATED CODE - DO NOT MODIFY BY HAND
// Generated from blog_post_schema.dart

import 'package:dart_tree/dart_tree.dart';

/// Generated TreeObject class for Reference
class ReferenceObject extends TreeObject {
  final StringValue? $ref;

  ReferenceObject({
    this.$ref,
  }) {
  }

  @override
  String toJson() {
    final buffer = StringBuffer();
    buffer.write('{');
    int index = 0;
    if (this.$ref != null) {
      if (index > 0) buffer.write(', ');
      index++;
      buffer.write('"\$ref": ');
      buffer.write(this.$ref!.toJson());
    }
    buffer.write('}');
    return buffer.toString();
  }

  @override
  String toYaml() {
    final buffer = StringBuffer();
    int index = 0;
    if (this.$ref != null) {
      if (index > 0) buffer.writeln();
      index++;
      buffer.write('\$ref: ');
      buffer.write(this.$ref!.toYaml());
    }
    return buffer.toString();
  }

  static ReferenceObject fromJson(String json) {
    final map = extractJsonObjectFields(json);
    return $checkedCreate(
      'ReferenceObject',
      map,
      ($checkedConvert) {
        final val = ReferenceObject(
          $ref: $checkedConvert('\$ref', (v) => v == null ? null : StringValue.fromJson(v as String)),
        );
        return val;
      },
    );
  }

  static ReferenceObject fromYaml(String yaml) {
    final map = extractYamlMappingFields(yaml);
    return $checkedCreate(
      'ReferenceObject',
      map,
      ($checkedConvert) {
        final val = ReferenceObject(
          $ref: $checkedConvert('\$ref', (v) => v == null ? null : StringValue.fromYaml(v as String)),
        );
        return val;
      },
    );
  }
}
