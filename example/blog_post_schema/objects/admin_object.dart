// GENERATED CODE - DO NOT MODIFY BY HAND
// Generated from blog_post_schema.dart

import 'package:dart_tree/dart_tree.dart';

/// Generated TreeObject class for Admin
class AdminObject extends TreeObject {
  final IntValue age;
  final StringValue address;

  AdminObject({
    required this.age,
    required this.address,
  }) {
    {if (age.value < 18.0) {throw ArgumentError('age must be >= 18.0');}}
    {if (address.value.length < 1 || address.value.length > 100) {throw ArgumentError('address must be 1-100 characters');}}
  }

  @override
  String toJson() {
    final buffer = StringBuffer();
    buffer.write('{');
    buffer.write('"${'age'}": ');
    buffer.write(age.toJson());
    buffer.write(', ');
    buffer.write('"${'address'}": ');
    buffer.write(address.toJson());
    buffer.write('}');
    return buffer.toString();
  }

  @override
  String toYaml() {
    final buffer = StringBuffer();
    buffer.write('age: ');
    buffer.write(age.toYaml());
    buffer.writeln();
    buffer.write('address: ');
    buffer.write(address.toYaml());
    return buffer.toString();
  }

  static AdminObject fromJson(String json) {
    final map = extractJsonObjectFields(json);
    return $checkedCreate(
      'AdminObject',
      map,
      ($checkedConvert) {
        $checkKeys(
          map,
          requiredKeys: const ['age', 'address'],
        );
        final val = AdminObject(
          age: $checkedConvert('age', (v) => IntValue.fromJson(v as String)),
          address: $checkedConvert('address', (v) => StringValue.fromJson(v as String)),
        );
        return val;
      },
    );
  }

  static AdminObject fromYaml(String yaml) {
    final map = extractYamlMappingFields(yaml);
    return $checkedCreate(
      'AdminObject',
      map,
      ($checkedConvert) {
        $checkKeys(
          map,
          requiredKeys: const ['age', 'address'],
        );
        final val = AdminObject(
          age: $checkedConvert('age', (v) => IntValue.fromYaml(v as String)),
          address: $checkedConvert('address', (v) => StringValue.fromYaml(v as String)),
        );
        return val;
      },
    );
  }
}
