import 'package:dart_tree/dart_tree.dart';

part 'blog_post_schema.g.dart';

@schema
const blogPost = $Object(
  title: 'BlogPost',
  required: ['title', 'content'],
  allowed: ['title', 'author', 'content', 'comments', 'user'],
  properties: {
    'title': $String(minLength: 1, maxLength: 100),
    'author': $String(minLength: 1, maxLength: 100),
    'content': $String(minLength: 1, maxLength: 1000),
    'comments': $Array(title: 'Comments', items: comment),
    'user': user,
  },
);

@schema
const comment = $Object(
  title: 'Comment',
  required: ['content'],
  properties: {'content': $String(minLength: 1, maxLength: 1000)},
);

@schema
const user = $Object(
  title: 'User',
  required: ['name', 'email'],
  properties: {'name': $String(minLength: 1, maxLength: 100), 'email': $String(minLength: 1, maxLength: 100)},
);

@schema
const admin = $Object(
  title: 'Admin',
  required: ['age', 'address'],
  properties: {'age': $Integer(minimum: 18), 'address': $String(minLength: 1, maxLength: 100)},
);

// Note: $Union support is not yet implemented
// @schema
// final person = $Union(title: 'Person', types: {user, admin});
