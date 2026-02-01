// GENERATED CODE - DO NOT MODIFY BY HAND
// Generated from blog_post_schema.dart

import 'package:dart_tree/dart_tree.dart';

/// Generated TreeObject class for Reference
class ReferenceObject extends TreeObject {
  final StringValue $ref;

  ReferenceObject({
    required this.$ref,
  });

  @override
  String toJson() {
    return '{"\$ref": ' + this.$ref.toJson() + '}';
  }

  @override
  String toYaml() {
    return '\$ref: ' + this.$ref.toYaml();
  }

  static ReferenceObject fromJson(String json) {
    final map = extractJsonObjectFields(json);
    return $checkedCreate(
      'ReferenceObject',
      map,
      ($checkedConvert) {
        $checkKeys(
          map,
          requiredKeys: const ['\$ref'],
        );
        final val = ReferenceObject(
          $ref: $checkedConvert('\$ref', (v) => StringValue.fromJson(v as String)),
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
        $checkKeys(
          map,
          requiredKeys: const ['\$ref'],
        );
        final val = ReferenceObject(
          $ref: $checkedConvert('\$ref', (v) => StringValue.fromYaml(v as String)),
        );
        return val;
      },
    );
  }
}
