// GENERATED CODE - DO NOT MODIFY BY HAND
// Generated from union_test_schema.dart

import 'package:dart_tree/dart_tree.dart';
import 'string_or_int_object.dart';
import 'mixed_value_object.dart';

/// Generated TreeObject class for Config
class ConfigObject extends TreeObject {
  final StringValue name;
  final StringOrIntObject port;
  final MixedValueObject? value;

  ConfigObject({
    required this.name,
    required this.port,
    this.value,
  }) {
  }

  @override
  String toJson() {
    final buffer = StringBuffer();
    buffer.write('{');
    buffer.write('"${'name'}": ');
    buffer.write(name.toJson());
    buffer.write(', ');
    buffer.write('"${'port'}": ');
    buffer.write(port.toJson());
    if (value != null) {
      buffer.write(', ');
      buffer.write('"${'value'}": ');
      buffer.write(value!.toJson());
    }
    buffer.write('}');
    return buffer.toString();
  }

  @override
  String toYaml() {
    final buffer = StringBuffer();
    buffer.write('name: ');
    buffer.write(name.toYaml());
    buffer.writeln();
    buffer.write('port: ');
    buffer.write(port.toYaml());
    if (value != null) {
      buffer.writeln();
      buffer.write('value: ');
      buffer.write(value!.toYaml());
    }
    return buffer.toString();
  }

  static ConfigObject fromJson(String json) {
    final map = extractJsonObjectFields(json);
    return $checkedCreate(
      'ConfigObject',
      map,
      ($checkedConvert) {
        $checkKeys(
          map,
          requiredKeys: const ['name', 'port'],
        );
        final val = ConfigObject(
          name: $checkedConvert('name', (v) => StringValue.fromJson(v as String)),
          port: $checkedConvert('port', (v) => UnionObject2.fromJson(v as String, (s) => StringValue.fromJson(s), (s) => IntValue.fromJson(s))),
          value: $checkedConvert('value', (v) => v == null ? null : UnionObject3.fromJson(v as String, (s) => StringValue.fromJson(s), (s) => IntValue.fromJson(s), (s) => BoolValue.fromJson(s))),
        );
        return val;
      },
    );
  }

  static ConfigObject fromYaml(String yaml) {
    final map = extractYamlMappingFields(yaml);
    return $checkedCreate(
      'ConfigObject',
      map,
      ($checkedConvert) {
        $checkKeys(
          map,
          requiredKeys: const ['name', 'port'],
        );
        final val = ConfigObject(
          name: $checkedConvert('name', (v) => StringValue.fromYaml(v as String)),
          port: $checkedConvert('port', (v) => UnionObject2.fromYaml(v as String, (s) => StringValue.fromYaml(s), (s) => IntValue.fromYaml(s))),
          value: $checkedConvert('value', (v) => v == null ? null : UnionObject3.fromYaml(v as String, (s) => StringValue.fromYaml(s), (s) => IntValue.fromYaml(s), (s) => BoolValue.fromYaml(s))),
        );
        return val;
      },
    );
  }
}
