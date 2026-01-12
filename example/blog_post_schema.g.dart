// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'blog_post_schema.dart';

// **************************************************************************
// SchemaBasedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// Generated from schema definitions

// ignore_for_file: unused_import, unused_element

import 'package:dart_tree/dart_tree.dart';

// ============================================================================
// GENERATED TREE OBJECT CLASSES
// ============================================================================

/// Generated TreeObject class for User
class UserObject extends TreeObject {
  final StringValue name;
  final StringValue email;

  UserObject({required this.name, required this.email}) {
    {
      if (name.value.length < 1 || name.value.length > 100) {
        throw ArgumentError('name must be 1-100 characters');
      }
    }
    {
      if (email.value.length < 1 || email.value.length > 100) {
        throw ArgumentError('email must be 1-100 characters');
      }
    }
  }

  @override
  String toJson() {
    final buffer = StringBuffer();
    buffer.write('{');
    int index = 0;
    if (index > 0) buffer.write(', ');
    buffer.write('"${'name'}": ');
    buffer.write(name.toJson());
    index++;
    if (index > 0) buffer.write(', ');
    buffer.write('"${'email'}": ');
    buffer.write(email.toJson());
    index++;
    buffer.write('}');
    return buffer.toString();
  }

  @override
  String toYaml() {
    final buffer = StringBuffer();
    int index = 0;
    if (index > 0) buffer.writeln();
    buffer.write('name: ');
    buffer.write(name.toYaml());
    index++;
    if (index > 0) buffer.writeln();
    buffer.write('email: ');
    buffer.write(email.toYaml());
    index++;
    return buffer.toString();
  }

  static UserObject fromJson(String json) {
    final map = extractJsonObjectFields(json);
    return UserObject(
      name: StringValue.fromJson(map['name']!),
      email: StringValue.fromJson(map['email']!),
    );
  }

  static UserObject fromYaml(String yaml) {
    final map = extractYamlMappingFields(yaml);
    return UserObject(
      name: StringValue.fromYaml(map['name']!),
      email: StringValue.fromYaml(map['email']!),
    );
  }
}

/// Generated TreeObject class for BlogPost
class BlogPostObject extends TreeObject {
  final StringValue title;
  final StringValue? author;
  final StringValue content;
  final ListObject<TreeObject>? comments;
  final UserObject? user;

  BlogPostObject({
    required this.title,
    this.author,
    required this.content,
    this.comments,
    this.user,
  }) {
    {
      if (title.value.length < 1 || title.value.length > 100) {
        throw ArgumentError('title must be 1-100 characters');
      }
    }
    if (author != null) {
      if (author.value.length < 1 || author.value.length > 100) {
        throw ArgumentError('author must be 1-100 characters');
      }
    }
    {
      if (content.value.length < 1 || content.value.length > 1000) {
        throw ArgumentError('content must be 1-1000 characters');
      }
    }
  }

  @override
  String toJson() {
    final buffer = StringBuffer();
    buffer.write('{');
    int index = 0;
    if (index > 0) buffer.write(', ');
    buffer.write('"${'title'}": ');
    buffer.write(title.toJson());
    index++;
    if (author != null) {
      if (index > 0) buffer.write(', ');
      buffer.write('"${'author'}": ');
      buffer.write(author!.toJson());
      index++;
    }
    if (index > 0) buffer.write(', ');
    buffer.write('"${'content'}": ');
    buffer.write(content.toJson());
    index++;
    if (comments != null) {
      if (index > 0) buffer.write(', ');
      buffer.write('"${'comments'}": ');
      buffer.write(comments!.toJson());
      index++;
    }
    if (user != null) {
      if (index > 0) buffer.write(', ');
      buffer.write('"${'user'}": ');
      buffer.write(user!.toJson());
      index++;
    }
    buffer.write('}');
    return buffer.toString();
  }

  @override
  String toYaml() {
    final buffer = StringBuffer();
    int index = 0;
    if (index > 0) buffer.writeln();
    buffer.write('title: ');
    buffer.write(title.toYaml());
    index++;
    if (author != null) {
      if (index > 0) buffer.writeln();
      buffer.write('author: ');
      buffer.write(author!.toYaml());
      index++;
    }
    if (index > 0) buffer.writeln();
    buffer.write('content: ');
    buffer.write(content.toYaml());
    index++;
    if (comments != null) {
      if (index > 0) buffer.writeln();
      buffer.write('comments: ');
      buffer.write(comments!.toYaml());
      index++;
    }
    if (user != null) {
      if (index > 0) buffer.writeln();
      buffer.write('user: ');
      buffer.write(user!.toYaml());
      index++;
    }
    return buffer.toString();
  }

  static BlogPostObject fromJson(String json) {
    final map = extractJsonObjectFields(json);
    return BlogPostObject(
      title: StringValue.fromJson(map['title']!),
      author: map.containsKey('author')
          ? StringValue.fromJson(map['author']!)
          : null,
      content: StringValue.fromJson(map['content']!),
      comments: map.containsKey('comments')
          ? ListObject.fromJson(map['comments']!)
          : null,
      user: map.containsKey('user') ? UserObject.fromJson(map['user']!) : null,
    );
  }

  static BlogPostObject fromYaml(String yaml) {
    final map = extractYamlMappingFields(yaml);
    return BlogPostObject(
      title: StringValue.fromYaml(map['title']!),
      author: map.containsKey('author')
          ? StringValue.fromYaml(map['author']!)
          : null,
      content: StringValue.fromYaml(map['content']!),
      comments: map.containsKey('comments')
          ? ListObject.fromYaml(map['comments']!)
          : null,
      user: map.containsKey('user') ? UserObject.fromYaml(map['user']!) : null,
    );
  }
}

/// Generated TreeObject class for Comment
class CommentObject extends TreeObject {
  final StringValue content;

  CommentObject({required this.content}) {
    {
      if (content.value.length < 1 || content.value.length > 1000) {
        throw ArgumentError('content must be 1-1000 characters');
      }
    }
  }

  @override
  String toJson() {
    final buffer = StringBuffer();
    buffer.write('{');
    int index = 0;
    if (index > 0) buffer.write(', ');
    buffer.write('"${'content'}": ');
    buffer.write(content.toJson());
    index++;
    buffer.write('}');
    return buffer.toString();
  }

  @override
  String toYaml() {
    final buffer = StringBuffer();
    int index = 0;
    if (index > 0) buffer.writeln();
    buffer.write('content: ');
    buffer.write(content.toYaml());
    index++;
    return buffer.toString();
  }

  static CommentObject fromJson(String json) {
    final map = extractJsonObjectFields(json);
    return CommentObject(content: StringValue.fromJson(map['content']!));
  }

  static CommentObject fromYaml(String yaml) {
    final map = extractYamlMappingFields(yaml);
    return CommentObject(content: StringValue.fromYaml(map['content']!));
  }
}

/// Generated TreeObject class for User
class UserObject extends TreeObject {
  final StringValue name;
  final StringValue email;

  UserObject({required this.name, required this.email}) {
    {
      if (name.value.length < 1 || name.value.length > 100) {
        throw ArgumentError('name must be 1-100 characters');
      }
    }
    {
      if (email.value.length < 1 || email.value.length > 100) {
        throw ArgumentError('email must be 1-100 characters');
      }
    }
  }

  @override
  String toJson() {
    final buffer = StringBuffer();
    buffer.write('{');
    int index = 0;
    if (index > 0) buffer.write(', ');
    buffer.write('"${'name'}": ');
    buffer.write(name.toJson());
    index++;
    if (index > 0) buffer.write(', ');
    buffer.write('"${'email'}": ');
    buffer.write(email.toJson());
    index++;
    buffer.write('}');
    return buffer.toString();
  }

  @override
  String toYaml() {
    final buffer = StringBuffer();
    int index = 0;
    if (index > 0) buffer.writeln();
    buffer.write('name: ');
    buffer.write(name.toYaml());
    index++;
    if (index > 0) buffer.writeln();
    buffer.write('email: ');
    buffer.write(email.toYaml());
    index++;
    return buffer.toString();
  }

  static UserObject fromJson(String json) {
    final map = extractJsonObjectFields(json);
    return UserObject(
      name: StringValue.fromJson(map['name']!),
      email: StringValue.fromJson(map['email']!),
    );
  }

  static UserObject fromYaml(String yaml) {
    final map = extractYamlMappingFields(yaml);
    return UserObject(
      name: StringValue.fromYaml(map['name']!),
      email: StringValue.fromYaml(map['email']!),
    );
  }
}

/// Generated TreeObject class for Admin
class AdminObject extends TreeObject {
  final IntValue age;
  final StringValue address;

  AdminObject({required this.age, required this.address}) {
    {
      if (age.value < 18.0) {
        throw ArgumentError('age must be >= 18.0');
      }
    }
    {
      if (address.value.length < 1 || address.value.length > 100) {
        throw ArgumentError('address must be 1-100 characters');
      }
    }
  }

  @override
  String toJson() {
    final buffer = StringBuffer();
    buffer.write('{');
    int index = 0;
    if (index > 0) buffer.write(', ');
    buffer.write('"${'age'}": ');
    buffer.write(age.toJson());
    index++;
    if (index > 0) buffer.write(', ');
    buffer.write('"${'address'}": ');
    buffer.write(address.toJson());
    index++;
    buffer.write('}');
    return buffer.toString();
  }

  @override
  String toYaml() {
    final buffer = StringBuffer();
    int index = 0;
    if (index > 0) buffer.writeln();
    buffer.write('age: ');
    buffer.write(age.toYaml());
    index++;
    if (index > 0) buffer.writeln();
    buffer.write('address: ');
    buffer.write(address.toYaml());
    index++;
    return buffer.toString();
  }

  static AdminObject fromJson(String json) {
    final map = extractJsonObjectFields(json);
    return AdminObject(
      age: IntValue.fromJson(map['age']!),
      address: StringValue.fromJson(map['address']!),
    );
  }

  static AdminObject fromYaml(String yaml) {
    final map = extractYamlMappingFields(yaml);
    return AdminObject(
      age: IntValue.fromYaml(map['age']!),
      address: StringValue.fromYaml(map['address']!),
    );
  }
}

// ============================================================================
// GENERATED TREE NODE CLASSES
// ============================================================================

/// Generated TreeNode class for User
class UserNode extends CollectionNode {
  UserNode({super.id});

  StringValueNode get name => $children!['name'] as StringValueNode;
  StringValueNode get email => $children!['email'] as StringValueNode;

  set name(String value) {
    if (value.length < 1 || value.length > 100) {
      throw ArgumentError('name must be 1-100 characters');
    }
    $children!['name'] = StringValueNode(StringValue(value));
  }

  set email(String value) {
    if (value.length < 1 || value.length > 100) {
      throw ArgumentError('email must be 1-100 characters');
    }
    $children!['email'] = StringValueNode(StringValue(value));
  }

  @override
  UserNode clone() => UserNode(id: id);
}

/// Generated TreeNode class for BlogPost
class BlogPostNode extends CollectionNode {
  BlogPostNode({super.id});

  StringValueNode get title => $children!['title'] as StringValueNode;
  StringValueNode? get author => $children?['author'] as StringValueNode?;
  StringValueNode get content => $children!['content'] as StringValueNode;
  ListTreeNode? get comments => $children?['comments'] as ListTreeNode?;
  UserNode? get user => $children?['user'] as UserNode?;

  set title(String value) {
    if (value.length < 1 || value.length > 100) {
      throw ArgumentError('title must be 1-100 characters');
    }
    $children!['title'] = StringValueNode(StringValue(value));
  }

  set author(String? value) {
    if (value == null) {
      $children?.remove('author');
      return;
    }
    if (value.length < 1 || value.length > 100) {
      throw ArgumentError('author must be 1-100 characters');
    }
    $children!['author'] = StringValueNode(StringValue(value));
  }

  set content(String value) {
    if (value.length < 1 || value.length > 1000) {
      throw ArgumentError('content must be 1-1000 characters');
    }
    $children!['content'] = StringValueNode(StringValue(value));
  }

  @override
  BlogPostNode clone() => BlogPostNode(id: id);
}

/// Generated TreeNode class for Comment
class CommentNode extends CollectionNode {
  CommentNode({super.id});

  StringValueNode get content => $children!['content'] as StringValueNode;

  set content(String value) {
    if (value.length < 1 || value.length > 1000) {
      throw ArgumentError('content must be 1-1000 characters');
    }
    $children!['content'] = StringValueNode(StringValue(value));
  }

  @override
  CommentNode clone() => CommentNode(id: id);
}

/// Generated TreeNode class for User
class UserNode extends CollectionNode {
  UserNode({super.id});

  StringValueNode get name => $children!['name'] as StringValueNode;
  StringValueNode get email => $children!['email'] as StringValueNode;

  set name(String value) {
    if (value.length < 1 || value.length > 100) {
      throw ArgumentError('name must be 1-100 characters');
    }
    $children!['name'] = StringValueNode(StringValue(value));
  }

  set email(String value) {
    if (value.length < 1 || value.length > 100) {
      throw ArgumentError('email must be 1-100 characters');
    }
    $children!['email'] = StringValueNode(StringValue(value));
  }

  @override
  UserNode clone() => UserNode(id: id);
}

/// Generated TreeNode class for Admin
class AdminNode extends CollectionNode {
  AdminNode({super.id});

  IntValueNode get age => $children!['age'] as IntValueNode;
  StringValueNode get address => $children!['address'] as StringValueNode;

  set age(int value) {
    if (value < 18.0) {
      throw ArgumentError('age must be >= 18.0');
    }
    $children!['age'] = IntValueNode(IntValue(value));
  }

  set address(String value) {
    if (value.length < 1 || value.length > 100) {
      throw ArgumentError('address must be 1-100 characters');
    }
    $children!['address'] = StringValueNode(StringValue(value));
  }

  @override
  AdminNode clone() => AdminNode(id: id);
}

// ============================================================================
// GENERATED TREE CLASS
// ============================================================================

/// Generated Tree class with objectToNode conversion.
class GeneratedTree extends Tree {
  GeneratedTree({required super.root});

  @override
  (TreeNode, List<(Edge, Object)>)? objectToNode(Object object) {
    // Handle value objects
    if (object is StringValue) return (StringValueNode(object), []);
    if (object is IntValue) return (IntValueNode(object), []);
    if (object is DoubleValue) return (DoubleValueNode(object), []);
    if (object is BoolValue) return (BoolValueNode(object), []);
    if (object is NullValue) return (NullValueNode(object), []);

    // Handle generated objects
    if (object is UserObject) {
      final edges = <(Edge, Object)>[];
      edges.add((Edge(StringValueNode, 'name'), object.name));
      edges.add((Edge(StringValueNode, 'email'), object.email));
      return (UserNode(), edges);
    }

    if (object is BlogPostObject) {
      final edges = <(Edge, Object)>[];
      edges.add((Edge(StringValueNode, 'title'), object.title));
      if (object.author != null) {
        edges.add((Edge(StringValueNode, 'author'), object.author!));
      }
      edges.add((Edge(StringValueNode, 'content'), object.content));
      if (object.comments != null) {
        edges.add((Edge(ListTreeNode, 'comments'), object.comments!));
      }
      if (object.user != null) {
        edges.add((Edge(UserNode, 'user'), object.user!));
      }
      return (BlogPostNode(), edges);
    }

    if (object is CommentObject) {
      final edges = <(Edge, Object)>[];
      edges.add((Edge(StringValueNode, 'content'), object.content));
      return (CommentNode(), edges);
    }

    if (object is UserObject) {
      final edges = <(Edge, Object)>[];
      edges.add((Edge(StringValueNode, 'name'), object.name));
      edges.add((Edge(StringValueNode, 'email'), object.email));
      return (UserNode(), edges);
    }

    if (object is AdminObject) {
      final edges = <(Edge, Object)>[];
      edges.add((Edge(IntValueNode, 'age'), object.age));
      edges.add((Edge(StringValueNode, 'address'), object.address));
      return (AdminNode(), edges);
    }

    return null;
  }
}
