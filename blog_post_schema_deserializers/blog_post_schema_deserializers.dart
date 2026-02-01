// GENERATED CODE - DO NOT MODIFY BY HAND
// Generated from blog_post_schema.dart

import 'package:dart_tree/dart_tree.dart';
import 'objects/user_object.dart';
import 'objects/admin_object.dart';
import 'objects/reference_object.dart';
import 'objects/comment_object.dart';
import 'objects/blog_post_object.dart';
import 'objects/person_object.dart';
import 'objects/ref_object.dart';

RefObject<BlogPostObject<UserObject, StringValue>>? x;

/// Generic fromJson function that dispatches to the correct type.
T fromJson<T extends TreeObject>(String json) {
  // if (T == AdminObject) return AdminObject.fromJson(json) as T;
  // if (T == CommentObject) return CommentObject.fromJson(json) as T;
  // if (T == PersonObject) return PersonObject.fromJson(json) as T;
  // if (T == ReferenceObject) return ReferenceObject.fromJson(json) as T;
  // if (T == UserObject) return UserObject.fromJson(json) as T;
  final typeStr = typeOf<T>().toString();
  final deserializer = _getDeserializer(typeStr);
  return deserializer(json) as T;
  // if (T == BlogPostObject) return BlogPostObject.fromJson(json) as T;
  throw UnsupportedError('Type $T is not supported for fromJson in this schema');
}

// ============ Deserializer types ============

typedef SimpleDeserializer = Object Function(String json);
typedef GenericDeserializer = Object Function(String json, List<SimpleDeserializer> typeArgDeserializers);

// ============ Registry ============

final Map<String, SimpleDeserializer> _simpleRegistry = {
  'AdminObject': (json) => AdminObject.fromJson(json),
  'CommentObject': (json) => CommentObject.fromJson(json),
  'PersonObject': (json) => PersonObject.fromJson(json),
  'ReferenceObject': (json) => ReferenceObject.fromJson(json),
  'UserObject': (json) => UserObject.fromJson(json),
};

final Map<String, GenericDeserializer> _genericRegistry = {
  'BlogPostObject': (json, deserializers) => BlogPostObject.fromJson(json, deserializers[0], deserializers[1]),
  'RefObject': (json, deserializers) => RefObject.fromJson(json, deserializers[0]),
};

// ============ Parsing: "Ref<Comment>" -> ("Ref", ["Comment"]) ============

(String base_, List<String> args) _parseTypeString(String typeStr) {
  final stripped = typeStr.trim();
  final angleStart = stripped.indexOf('<');

  if (angleStart == -1) {
    return (stripped, []);
  }

  final base = stripped.substring(0, angleStart).trim();
  final argsStr = stripped.substring(angleStart + 1, stripped.length - 1);
  final args = _parseTypeArgList(argsStr);
  return (base, args);
}

// Handles "Comment" and "Ref<Comment>" and "Pair<User,Comment>"
List<String> _parseTypeArgList(String s) {
  final result = <String>[];
  var i = 0;
  var depth = 0;
  var start = 0;

  while (i < s.length) {
    final c = s[i];
    if (c == '<') {
      depth++;
    } else if (c == '>') {
      depth--;
    } else if ((c == ',' && depth == 0) || i == s.length - 1) {
      final end = i == s.length - 1 ? i + 1 : i;
      result.add(s.substring(start, end).trim());
      start = i + 1;
    }
    i++;
  }
  return result;
}

// ============ Main: get deserializer for a type string ============

SimpleDeserializer _getDeserializer(String typeStr) {
  final (base, args) = _parseTypeString(typeStr);

  if (args.isEmpty) {
    final simple = _simpleRegistry[base];
    if (simple != null) return simple;
    throw UnsupportedError('Unknown type: $typeStr');
  }

  final generic = _genericRegistry[base];
  if (generic == null) throw UnsupportedError('Unknown generic type: $base');

  // Recursively get deserializers for each type argument
  final argDeserializers = args.map(_getDeserializer).toList();

  // Return a closure that calls the generic deserializer with those arg deserializers
  return (json) => generic(json, argDeserializers);
}

// ============ Public API ============

Type typeOf<T>() => T;

// T fromJson<T>(String json) {
//   // typeOf<T>().toString() often gives something like "Ref<Comment>"
//   final typeStr = typeOf<T>().toString();
//   final deserializer = _getDeserializer(typeStr);
//   return deserializer(json) as T;
// }

/// Generic fromYaml function that dispatches to the correct type.
T fromYaml<T extends TreeObject>(String yaml) {
  if (T == UserObject) return UserObject.fromYaml(yaml) as T;
  if (T == AdminObject) return AdminObject.fromYaml(yaml) as T;
  if (T == ReferenceObject) return ReferenceObject.fromYaml(yaml) as T;
  if (T == CommentObject) return CommentObject.fromYaml(yaml) as T;
  if (T == BlogPostObject) return BlogPostObject.fromYaml(yaml) as T;
  throw UnsupportedError('Type $T is not supported for fromYaml in this schema');
}
