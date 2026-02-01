void main() {
  final bar = Bar<Foo<int>>();
  bar.printType();
}

class Foo<T> {}

class Bar<T> {
  void printType() {
    bool isFoo = T == Foo<dynamic>;
    print(T);
    print(isFoo);
    bool isFooOfAnyType = <T>[] is List<Foo>;
    print(isFooOfAnyType);
  }
}

// ============ Deserializer types ============

typedef SimpleDeserializer = Object Function(String json);
typedef GenericDeserializer = Object Function(
  String json,
  List<SimpleDeserializer> typeArgDeserializers,
);

// ============ Registry ============

final Map<String, SimpleDeserializer> _simpleRegistry = {
  'User': (json) => User.fromJson(json),
  'Comment': (json) => Comment.fromJson(json),
};

final Map<String, GenericDeserializer> _genericRegistry = {
  'Ref': (json, deserializers) => Ref.fromJsonWith(json, deserializers[0]),
  'Pair': (json, deserializers) => Pair.fromJsonWith(
    json,
    deserializers[0],
    deserializers[1],
  ),
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

T fromJson<T>(String json) {
  // typeOf<T>().toString() often gives something like "Ref<Comment>"
  final typeStr = typeOf<T>().toString();
  final deserializer = _getDeserializer(typeStr);
  return deserializer(json) as T;
}