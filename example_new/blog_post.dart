import 'package:dart_tree/src/json_schema/json_schema.dart';

@jsonSchema
final blogPost = $Object(
  title: 'BlogPost',
  properties: {
    'title': $String(minLength: 1, maxLength: 100),
    'author': $String(minLength: 1, maxLength: 100),
    'content': $String(minLength: 1, maxLength: 1000),
    'comments': $Array(title: 'comments', items: comment),
    'user': user,
  },
);

@jsonSchema
final comment = $Object(
  title: 'Comment',
  properties: {'content': $String(minLength: 1, maxLength: 1000)},
);

@jsonSchema
final user = $Object(
  title: 'User',
  properties: {
    'name': $String(minLength: 1, maxLength: 100),
    'email': $String(minLength: 1, maxLength: 100),
  },
);

@jsonSchema
final admin = $Object(
  title: 'Admin',
  properties: {'age': $Integer(minimum: 18), 'address': $String(minLength: 1, maxLength: 100)},
);

@jsonSchema
final person = $Union(title: 'Person', types: {user, admin});
