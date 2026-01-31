import 'package:dart_tree_gen/dart_tree_gen.dart';

@tree
const treew = $Tree(
  name: 'BlogPostSchemaTree',
  schemas: [BlogPost.schema, Comment.schema, User.schema, Admin.schema, Person.schema, Reference.schema, Ref.schema],
);

abstract class BlogPost {
  // name
  static const String SCHEMA_NAME = 'BlogPost';
  // type parameters
  static const String T = 'T';
  static const String U = 'U';
  // properties
  static const String TITLE = 'title';
  static const String AUTHOR = 'author';
  static const String CONTENT = 'content';
  static const String COMMENTS = 'comments';
  static const String EXTRA = 'extra';
  static const String USER = 'user';

  static const schema = $Schema(
    name: SCHEMA_NAME,
    typeParameters: {T, U},
    properties: {
      TITLE: $String(),
      AUTHOR: $String(),
      CONTENT: $String(),
      COMMENTS: $Array(items: $Object(schema: Comment.schema)),
      EXTRA: $TypeParameter(T),
      USER: $Object(schema: User.schema, typeParameters: {T: $String()}),
    },
    required: [TITLE, CONTENT],
    allowed: [TITLE, AUTHOR, CONTENT, COMMENTS, USER],
  );
}

abstract class Comment {
  // name
  static const String SCHEMA_NAME = 'Comment';
  // properties
  static const String CONTENT = 'content';
  static const String INDEX = 'index';
  static const String BUFFER = 'buffer';
  static const String PERSON = 'person';

  static const schema = $Schema(
    name: SCHEMA_NAME,
    properties: {
      CONTENT: $String(),
      INDEX: $Integer(),
      BUFFER: $String(),
      PERSON: $Object(schema: Person.schema),
    },
    required: [CONTENT, INDEX, BUFFER, PERSON],
  );
}

abstract class User {
  // name
  static const String SCHEMA_NAME = 'User';
  // properties
  static const String NAME = 'name';
  static const String EMAIL = 'email';

  static const schema = $Schema(
    name: SCHEMA_NAME,
    properties: {NAME: $String(), EMAIL: $String()},
    required: [NAME, EMAIL],
  );
}

abstract class Admin {
  // name
  static const String SCHEMA_NAME = 'Admin';
  // properties
  static const String AGE = 'age';
  static const String ADDRESS = 'address';

  static const schema = $Schema(
    name: SCHEMA_NAME,
    properties: {AGE: $Integer(), ADDRESS: $String()},
    required: [AGE, ADDRESS],
  );
}

abstract class Person {
  // name
  static const String SCHEMA_NAME = 'Person';

  static const schema = $Union(
    name: SCHEMA_NAME,
    types: {
      $Object(schema: User.schema),
      $Object(schema: Admin.schema),
    },
  );
}

abstract class Reference {
  // name
  static const String SCHEMA_NAME = 'Reference';
  // properties
  static const String REF = r'$ref';

  static const schema = $Schema(name: SCHEMA_NAME, properties: {REF: $String()}, required: [REF]);
}

abstract class Ref {
  // name
  static const String SCHEMA_NAME = 'Ref';
  // type parameters
  static const String T = 'T';

  static const schema = $Union(
    name: SCHEMA_NAME,
    typeParameters: {T},
    types: {
      $Object(schema: Reference.schema),
      $Object(schema: Admin.schema),
    },
  );
}
