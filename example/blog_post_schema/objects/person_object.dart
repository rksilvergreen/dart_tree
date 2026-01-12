// GENERATED CODE - DO NOT MODIFY BY HAND
// Generated from blog_post_schema.dart

import 'package:dart_tree/dart_tree.dart';
import 'user_object.dart';
import 'admin_object.dart';

/// Generated union type for Person
// typedef PersonObject = UnionObject2<UserObject, AdminObject>;

class PersonObject extends UnionObject2<UserObject, AdminObject> {
  UserObject? get user => this.asFirst;
  AdminObject? get admin => this.asSecond;
  PersonObject._(super.value);
  factory PersonObject.first(UserObject value) => PersonObject._(UnionObject2.first(value));
  factory PersonObject.second(AdminObject value) => PersonObject._(UnionObject2.second(value));
}

extension $PersonObject on PersonObject {
  UserObject get user => this.asFirst!;
  AdminObject get admin => this.asSecond!;
}
