// GENERATED CODE - DO NOT MODIFY BY HAND
// Generated from blog_post_schema.dart

import 'package:dart_tree/dart_tree.dart';

/// Generated TreeObject class for User
class UserObject extends TreeObject {
  final StringValue name;
  final StringValue email;

  UserObject({
    required this.name,
    required this.email,
  }) {
    {if (name.value.length < 1 || name.value.length > 100) {throw ArgumentError('name must be 1-100 characters');}}
    {if (email.value.length < 1 || email.value.length > 100) {throw ArgumentError('email must be 1-100 characters');}}
  }

  @override
  String toJson() {
    final buffer = StringBuffer();
    buffer.write('{');
    buffer.write('"${'name'}": ');
    buffer.write(name.toJson());
    buffer.write(', ');
    buffer.write('"${'email'}": ');
    buffer.write(email.toJson());
    buffer.write('}');
    return buffer.toString();
  }

  @override
  String toYaml() {
    final buffer = StringBuffer();
    buffer.write('name: ');
    buffer.write(name.toYaml());
    buffer.writeln();
    buffer.write('email: ');
    buffer.write(email.toYaml());
    return buffer.toString();
  }

  static UserObject fromJson(String json) {
    final map = extractJsonObjectFields(json);
    return $checkedCreate(
      'UserObject',
      map,
      ($checkedConvert) {
        $checkKeys(
          map,
          requiredKeys: const ['name', 'email'],
        );
        final val = UserObject(
          name: $checkedConvert('name', (v) => StringValue.fromJson(v as String)),
          email: $checkedConvert('email', (v) => StringValue.fromJson(v as String)),
        );
        return val;
      },
    );
  }

  static UserObject fromYaml(String yaml) {
    final map = extractYamlMappingFields(yaml);
    return $checkedCreate(
      'UserObject',
      map,
      ($checkedConvert) {
        $checkKeys(
          map,
          requiredKeys: const ['name', 'email'],
        );
        final val = UserObject(
          name: $checkedConvert('name', (v) => StringValue.fromYaml(v as String)),
          email: $checkedConvert('email', (v) => StringValue.fromYaml(v as String)),
        );
        return val;
      },
    );
  }
}
