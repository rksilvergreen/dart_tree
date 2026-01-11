// ignore_for_file: unused_element, library_private_types_in_public_api

/// GENERATED CODE - DO NOT MODIFY BY HAND
///
/// This file demonstrates what the code generator would create.
/// In reality, this would be generated automatically by dart_tree_gen.
///
/// NEW ARCHITECTURE:
/// - Extension on user's Tree class (not inheritance)
/// - Serialization extensions for each TreeObject
/// - TreeNode classes with type-safe accessors
part of 'manual_domain_example.dart';

// =============================================================================
// GENERATED TREE NODES
// =============================================================================

/// Generated node for BlogPost
class BlogPostNode extends CollectionNode {
  BlogPostNode({super.id});

  StringValueNode get title => $children!['title']! as StringValueNode;
  StringValueNode? get author => $children?['author'] as StringValueNode?;
  ContentNode get content => $children!['content']! as ContentNode;
  CommentsListNode get comments => $children!['comments']! as CommentsListNode;

  @override
  BlogPostNode clone() => BlogPostNode(id: id);
}

/// Generated node for Content
class ContentNode extends CollectionNode {
  ContentNode({super.id});

  StringValueNode get body => $children!['body']! as StringValueNode;
  IntValueNode? get wordCount => $children?['wordCount'] as IntValueNode?;

  @override
  ContentNode clone() => ContentNode(id: id);
}

/// Generated node for Comment
class CommentNode extends CollectionNode {
  CommentNode({super.id});

  StringValueNode get author => $children!['author']! as StringValueNode;
  StringValueNode get text => $children!['text']! as StringValueNode;
  BoolValueNode get approved => $children!['approved']! as BoolValueNode;

  @override
  CommentNode clone() => CommentNode(id: id);
}

/// Generated list node for CommentsList
class CommentsListNode extends ListTreeNode<CommentNode> {
  CommentsListNode({super.id});

  @override
  CommentsListNode clone() => CommentsListNode(id: id);
}

/// Generated map node for ContentMap
class ContentMapNode extends MapTreeNode<ContentNode> {
  ContentMapNode({super.id});

  @override
  ContentMapNode clone() => ContentMapNode(id: id);
}

// =============================================================================
// GENERATED TREE EXTENSION
// =============================================================================

/// Generated extension with objectToNode conversion logic
extension BlogTreeExtension on BlogTree {
  (TreeNode, List<(Edge, Object)>)? objectToNode(Object object) {
    // Value objects
    if (object is StringValue) {
      return (StringValueNode(object), []);
    }
    if (object is IntValue) {
      return (IntValueNode(object), []);
    }
    if (object is BoolValue) {
      return (BoolValueNode(object), []);
    }
    if (object is DoubleValue) {
      return (DoubleValueNode(object), []);
    }
    if (object is NullValue) {
      return (NullValueNode(object), []);
    }

    // Domain objects
    if (object is BlogPost) {
      final edges = <(Edge, Object)>[(Edge(StringValueNode, 'title'), object.title)];

      if (object.author != null) {
        edges.add((Edge(StringValueNode, 'author'), object.author!));
      }

      edges.add((Edge(ContentNode, 'content'), object.content));
      edges.add((Edge(CommentsListNode, 'comments'), object.comments));

      return (BlogPostNode(), edges);
    }

    if (object is Content) {
      final edges = <(Edge, Object)>[(Edge(StringValueNode, 'body'), object.body)];

      if (object.wordCount != null) {
        edges.add((Edge(IntValueNode, 'wordCount'), object.wordCount!));
      }

      return (ContentNode(), edges);
    }

    if (object is Comment) {
      return (
        CommentNode(),
        [
          (Edge(StringValueNode, 'author'), object.author),
          (Edge(StringValueNode, 'text'), object.text),
          (Edge(BoolValueNode, 'approved'), object.approved),
        ],
      );
    }

    if (object is CommentsList) {
      final edges = <(Edge, Object)>[];
      for (var i = 0; i < object.length; i++) {
        edges.add((Edge(CommentNode, '$i'), object[i]));
      }
      return (CommentsListNode(), edges);
    }

    if (object is ContentMap) {
      final edges = <(Edge, Object)>[];
      for (var entry in object.entries) {
        edges.add((Edge(ContentNode, entry.key), entry.value));
      }
      return (ContentMapNode(), edges);
    }

    return null;
  }
}

// =============================================================================
// GENERATED SERIALIZATION EXTENSIONS
// =============================================================================
// Note: In real generated code, these would be ordered so dependencies come first.
// For this manual example, we'll define them in dependency order.

/// Serializes [Content] to a JSON string.
String _$ContentToJson(Content instance) {
  final buffer = StringBuffer();
  buffer.write('{');
  int index = 0;
  if (index > 0) buffer.write(', ');
  buffer.write('"${'body'}": ');
  buffer.write(instance.body.toJson());
  index++;
  if (instance.wordCount != null) {
    if (index > 0) buffer.write(', ');
    buffer.write('"${'wordCount'}": ');
    buffer.write(instance.wordCount!.toJson());
    index++;
  }
  buffer.write('}');
  return buffer.toString();
}

/// Serializes [Content] to a YAML string.
String _$ContentToYaml(Content instance) {
  final buffer = StringBuffer();
  int index = 0;
  if (index > 0) buffer.writeln();
  buffer.write('body: ');
  buffer.write(instance.body.toYaml());
  index++;
  if (instance.wordCount != null) {
    if (index > 0) buffer.writeln();
    buffer.write('wordCount: ');
    buffer.write(instance.wordCount!.toYaml());
    index++;
  }
  return buffer.toString();
}

/// Deserializes [Content] from JSON.
Content _$ContentFromJson(dynamic json) {
  if (json is! Map<String, dynamic>) {
    throw ArgumentError('Expected Map<String, dynamic>, got ${json.runtimeType}');
  }
  return Content(
    body: StringValue.fromJson(json['body']),
    wordCount: json['wordCount'] == null ? null : IntValue.fromJson(json['wordCount']),
  );
}

/// Deserializes [Content] from YAML.
Content _$ContentFromYaml(dynamic yaml) {
  if (yaml is! Map) {
    throw ArgumentError('Expected Map, got ${yaml.runtimeType}');
  }
  return Content(
    body: StringValue.fromYaml(yaml['body']),
    wordCount: yaml['wordCount'] == null ? null : IntValue.fromYaml(yaml['wordCount']),
  );
}

/// Serializes [Comment] to a JSON string.
String _$CommentToJson(Comment instance) {
  final buffer = StringBuffer();
  buffer.write('{');
  int index = 0;
  if (index > 0) buffer.write(', ');
  buffer.write('"${'author'}": ');
  buffer.write(instance.author.toJson());
  index++;
  if (index > 0) buffer.write(', ');
  buffer.write('"${'text'}": ');
  buffer.write(instance.text.toJson());
  index++;
  if (index > 0) buffer.write(', ');
  buffer.write('"${'approved'}": ');
  buffer.write(instance.approved.toJson());
  index++;
  buffer.write('}');
  return buffer.toString();
}

/// Serializes [Comment] to a YAML string.
String _$CommentToYaml(Comment instance) {
  final buffer = StringBuffer();
  int index = 0;
  if (index > 0) buffer.writeln();
  buffer.write('author: ');
  buffer.write(instance.author.toYaml());
  index++;
  if (index > 0) buffer.writeln();
  buffer.write('text: ');
  buffer.write(instance.text.toYaml());
  index++;
  if (index > 0) buffer.writeln();
  buffer.write('approved: ');
  buffer.write(instance.approved.toYaml());
  index++;
  return buffer.toString();
}

/// Deserializes [Comment] from JSON.
Comment _$CommentFromJson(dynamic json) {
  if (json is! Map<String, dynamic>) {
    throw ArgumentError('Expected Map<String, dynamic>, got ${json.runtimeType}');
  }
  return Comment(
    author: StringValue.fromJson(json['author']),
    text: StringValue.fromJson(json['text']),
    approved: BoolValue.fromJson(json['approved']),
  );
}

/// Deserializes [Comment] from YAML.
Comment _$CommentFromYaml(dynamic yaml) {
  if (yaml is! Map) {
    throw ArgumentError('Expected Map, got ${yaml.runtimeType}');
  }
  return Comment(
    author: StringValue.fromYaml(yaml['author']),
    text: StringValue.fromYaml(yaml['text']),
    approved: BoolValue.fromYaml(yaml['approved']),
  );
}

/// Generated serialization methods for Comment
extension CommentSerialization on Comment {
  String toJson() {
    return _$CommentToJson(this);
  }

  String toYaml() {
    return _$CommentToYaml(this);
  }

  static Comment fromJson(dynamic json) {
    return _$CommentFromJson(json);
  }

  static Comment fromYaml(dynamic yaml) {
    return _$CommentFromYaml(yaml);
  }
}

/// Deserializes [CommentsList] from JSON.
CommentsList _$CommentsListFromJson(dynamic json) {
  if (json is! List) {
    throw ArgumentError('Expected List, got ${json.runtimeType}');
  }
  return CommentsList(json.map((e) => CommentSerialization.fromJson(e)).toList());
}

/// Deserializes [CommentsList] from YAML.
CommentsList _$CommentsListFromYaml(dynamic yaml) {
  if (yaml is! List && yaml is! Iterable) {
    throw ArgumentError('Expected List or Iterable, got ${yaml.runtimeType}');
  }
  return CommentsList((yaml as Iterable).map((e) => CommentSerialization.fromYaml(e)).toList());
}

/// Generated serialization methods for CommentsList
extension CommentsListSerialization on CommentsList {
  static CommentsList fromJson(dynamic json) {
    return _$CommentsListFromJson(json);
  }

  static CommentsList fromYaml(dynamic yaml) {
    return _$CommentsListFromYaml(yaml);
  }
}

/// Deserializes [ContentMap] from JSON.
ContentMap _$ContentMapFromJson(dynamic json) {
  if (json is! Map<String, dynamic>) {
    throw ArgumentError('Expected Map<String, dynamic>, got ${json.runtimeType}');
  }
  return ContentMap(json.map((key, value) => MapEntry(key, ContentSerialization.fromJson(value))));
}

/// Deserializes [ContentMap] from YAML.
ContentMap _$ContentMapFromYaml(dynamic yaml) {
  if (yaml is! Map) {
    throw ArgumentError('Expected Map, got ${yaml.runtimeType}');
  }
  return ContentMap(yaml.map((key, value) => MapEntry(key.toString(), ContentSerialization.fromYaml(value))));
}

/// Generated serialization methods for ContentMap
extension ContentMapSerialization on ContentMap {
  static ContentMap fromJson(dynamic json) {
    return _$ContentMapFromJson(json);
  }

  static ContentMap fromYaml(dynamic yaml) {
    return _$ContentMapFromYaml(yaml);
  }
}

/// Serializes [BlogPost] to a JSON string.
String _$BlogPostToJson(BlogPost instance) {
  final buffer = StringBuffer();
  buffer.write('{');
  int index = 0;
  if (index > 0) buffer.write(', ');
  buffer.write('"${'title'}": ');
  buffer.write(instance.title.toJson());
  index++;
  if (instance.author != null) {
    if (index > 0) buffer.write(', ');
    buffer.write('"${'author'}": ');
    buffer.write(instance.author!.toJson());
    index++;
  }
  if (index > 0) buffer.write(', ');
  buffer.write('"${'content'}": ');
  buffer.write(instance.content.toJson());
  index++;
  if (index > 0) buffer.write(', ');
  buffer.write('"${'comments'}": ');
  buffer.write(instance.comments.toJson());
  index++;
  buffer.write('}');
  return buffer.toString();
}

/// Serializes [BlogPost] to a YAML string.
String _$BlogPostToYaml(BlogPost instance) {
  final buffer = StringBuffer();
  int index = 0;
  if (index > 0) buffer.writeln();
  buffer.write('title: ');
  buffer.write(instance.title.toYaml());
  index++;
  if (instance.author != null) {
    if (index > 0) buffer.writeln();
    buffer.write('author: ');
    buffer.write(instance.author!.toYaml());
    index++;
  }
  if (index > 0) buffer.writeln();
  buffer.write('content: ');
  buffer.write(instance.content.toYaml());
  index++;
  if (index > 0) buffer.writeln();
  buffer.write('comments: ');
  buffer.write(instance.comments.toYaml());
  index++;
  return buffer.toString();
}

/// Deserializes [BlogPost] from JSON.
BlogPost _$BlogPostFromJson(dynamic json) {
  if (json is! Map<String, dynamic>) {
    throw ArgumentError('Expected Map<String, dynamic>, got ${json.runtimeType}');
  }
  return BlogPost(
    title: StringValue.fromJson(json['title']),
    author: json['author'] == null ? null : StringValue.fromJson(json['author']),
    content: ContentSerialization.fromJson(json['content']),
    comments: CommentsListSerialization.fromJson(json['comments']),
  );
}

/// Deserializes [BlogPost] from YAML.
BlogPost _$BlogPostFromYaml(dynamic yaml) {
  if (yaml is! Map) {
    throw ArgumentError('Expected Map, got ${yaml.runtimeType}');
  }
  return BlogPost(
    title: StringValue.fromYaml(yaml['title']),
    author: yaml['author'] == null ? null : StringValue.fromYaml(yaml['author']),
    content: ContentSerialization.fromYaml(yaml['content']),
    comments: CommentsListSerialization.fromYaml(yaml['comments']),
  );
}

/// Generated serialization methods for BlogPost
extension BlogPostSerialization on BlogPost {
  String toJson() {
    return _$BlogPostToJson(this);
  }

  String toYaml() {
    return _$BlogPostToYaml(this);
  }

  static BlogPost fromJson(dynamic json) {
    return _$BlogPostFromJson(json);
  }

  static BlogPost fromYaml(dynamic yaml) {
    return _$BlogPostFromYaml(yaml);
  }
}

/// Generated serialization methods for Content
extension ContentSerialization on Content {
  String toJson() {
    return _$ContentToJson(this);
  }

  String toYaml() {
    return _$ContentToYaml(this);
  }

  static Content fromJson(dynamic json) {
    return _$ContentFromJson(json);
  }

  static Content fromYaml(dynamic yaml) {
    return _$ContentFromYaml(yaml);
  }
}
