import 'package:dart_tree/dart_tree.dart';

class BaseObject extends MapObject<BaseObject> {

  BaseObject({super.entries});

  @override
  String toJson() {
    return '{"entries": ${entries.map((key, value) => '$key: ${value.toJson()}').join(', ')}}';
  }

  @override
  String toYaml() {
    return 'entries: ${entries.map((key, value) => '$key: ${value.toYaml()}').join(', ')}';
  }
}