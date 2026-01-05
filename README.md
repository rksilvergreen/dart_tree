# dart_tree

A powerful Dart library for building domain-specific tree structures with automatic code generation. Define your data model once, and get type-safe tree navigation, traversal, and manipulation automatically.

## 🎯 Key Features

- **Zero Boilerplate**: Define domain objects once, code generation handles the rest
- **Type Safety**: Strongly-typed navigation with full IDE support  
- **Syntactic Preservation**: Parse JSON/YAML and preserve formatting for perfect round-tripping
- **Two-Tier Architecture**: Clean separation between domain objects and tree nodes
- **Powerful Operations**: Traverse, query, mutate with mutable & immutable APIs
- **Flexible**: Works with any domain model (OpenAPI, JSON Schema, custom formats)

## 🚀 Quick Start

### 1. Add Dependencies

```yaml
dependencies:
  dart_tree: ^1.0.0

dev_dependencies:
  dart_tree_gen: ^1.0.0
  build_runner: ^2.4.0
```

### 2. Define Your Domain Model

```dart
import 'package:dart_tree/dart_tree.dart';

part 'blog.g.dart';  // Generated file

// Define domain objects using TreeObject types (not primitives!)
@treeObject
class BlogPost extends TreeObject {
  final StringValue title;
  final StringValue? author;
  
  @TreeChild()
  final Content content;
  
  @TreeChild()
  final List<Comment> comments;
  
  BlogPost({
    required this.title,
    this.author,
    required this.content,
    this.comments = const [],
  });
}

@treeObject
class Content extends TreeObject {
  final StringValue body;
  final IntValue? wordCount;
  
  Content({required this.body, this.wordCount});
}

// Mark where your Tree should be generated
@GenerateTree()
abstract class BlogTreeBase extends Tree {
  BlogTreeBase({required super.root});
}
```

### 3. Generate Code

```bash
dart run build_runner build
```

### 4. Use Your Tree

```dart
// Build domain objects naturally
final post = BlogPost(
  title: const StringValue('My First Post'),
  author: const StringValue('Alice'),
  content: Content(
    body: const StringValue('This is the content...'),
    wordCount: const IntValue(42),
  ),
  comments: [
    Comment(
      author: const StringValue('Bob'),
      text: const StringValue('Great post!'),
    ),
  ],
);

// Convert to tree (generated BlogTree extends BlogTreeBase)
final tree = BlogTree(root: post);

// Navigate using generated nodes
final postNode = tree.root as BlogPostNode;
print(postNode.title.value);                    // "My First Post"
print(postNode.content.body.value);             // "This is the content..."
print(postNode.comments.length);                // 1

// Tree operations
tree.traverse((node, depth, path) {
  print('${"  " * depth}${node.runtimeType} @ $path');
});

// Query by path
final firstCommentAuthor = tree.getString('/comments/0/author');
print('First comment by: $firstCommentAuthor');
```

## 🏗️ Architecture

dart_tree uses a **two-tier architecture** inspired by Flutter's Widget/Element pattern:

### TreeObject (Domain Layer)
Your data model - clean, serializable objects with no tree pollution:
```dart
@treeObject
class Operation extends TreeObject {
  final StringValue? operationId;
  @TreeChild()
  final RequestBody? requestBody;
}
```

### TreeNode (Tree Layer)
Generated counterparts with tree navigation:
```dart
// GENERATED
class OperationNode extends TreeNode {
  StringValueNode? get operationId => ...;
  RequestBodyNode? get requestBody => ...;
}
```

### Tree (Container)
Links your domain to the tree system:
```dart
@GenerateTree()
abstract class MyDomainTree extends Tree {
  MyDomainTree({required super.root});
}

// Generator creates implementation with objectToNode()
```

See [ARCHITECTURE.md](ARCHITECTURE.md) for detailed documentation.

## 📝 Value Objects

**Critical:** Use TreeObject types, not primitives!

```dart
// ❌ WRONG
class Operation extends TreeObject {
  final String? operationId;  // NO!
  final bool enabled;         // NO!
}

// ✅ CORRECT
class Operation extends TreeObject {
  final StringValue? operationId;  // YES!
  final BoolValue enabled;         // YES!
}
```

**Why?** Value objects preserve syntactic metadata (quote styles, number formats) enabling perfect JSON/YAML round-tripping.

**Built-in value objects:**
- `StringValue` - with quote style (single/double/none)
- `IntValue` - with format (decimal/hex/octal)
- `DoubleValue` - with precision
- `BoolValue`
- `NullValue`

## 🔄 Tree Operations

### Traversal

```dart
// Pre-order, post-order, breadth-first
tree.traverse((node, depth, path) {
  print('${node.runtimeType} @ $path');
}, order: TraversalOrder.preOrder);

// Find operations
final allInts = tree.findAll((node) => node is IntValueNode);
final firstString = tree.findFirst((node) => node is StringValueNode);
```

### Querying

```dart
// Path-based queries (JSON Pointer format)
final node = tree.query('/users/0/name');
final exists = tree.exists('/users/0');

// Type-safe value accessors
final name = tree.getString('/users/0/name');
final age = tree.getInt('/users/0/age');
```

### Mutation

```dart
// Mutable (in-place)
tree.updateAt('/users/0/name', StringValue('Alice'));
tree.deleteAt('/users/0/email');

// Immutable (returns new tree)
final newTree = tree.replaceAt('/users/0/name', StringValue('Bob'));
final newTree2 = tree.withoutAt('/users/0/email');
```

## 🌳 Collections

Maps and Lists are automatically converted to tree nodes:

```dart
@treeObject
class Config extends TreeObject {
  @TreeChild()
  final Map<String, Setting> settings;  // → SettingsMapNode
  
  @TreeChild()
  final List<Plugin> plugins;           // → PluginsListNode
}

// Use like normal collections
configNode.settings['timeout'].value;
configNode.plugins[0].name;
```

## 📦 JSON/YAML Integration

```dart
// Parse with syntactic preservation
final tree = TreeIO.fromJson(jsonString, preserveSyntax: true);
final tree = TreeIO.fromYaml(yamlString, preserveSyntax: true);

// Access nodes with source positions
final node = tree.query('/version');
print('Found at line ${node.sourceRange?.start.line}');

// Serialize with format preservation
final output = tree.toJson(preserveFormatting: true);
final yaml = tree.toYaml(preserveFormatting: true);
```

## 📚 Examples

- `example/manual_domain_example.dart` - Complete architecture demonstration
- `example/basic_usage.dart` - Coming soon (after generator)
- `example/openapi_subset.dart` - Coming soon (after generator)

## 🛠️ Development Status

### ✅ Core Library (Complete)
- TreeObject base class and value objects
- TreeNode infrastructure
- Abstract Tree with objectToNode pattern
- All tree operations (traverse, query, mutate)
- JSON/YAML I/O with syntactic preservation
- Comprehensive documentation and examples

### 🚧 Code Generator (Next Phase)
- Analyzer for @treeObject classes
- TreeNode class generation
- Tree subclass generation
- build_runner integration

See `example/manual_domain_example.dart` for what the generator will create.

## 🤝 Contributing

The core library is complete. The next phase is building the code generator (`dart_tree_gen` package). Contributions welcome!

## 📄 License

MIT License

## 🔗 Related Projects

- **openapi_analyzer**: OpenAPI specification analyzer built on dart_tree
- **dart_tree_gen**: Code generator for dart_tree (in development)

---

**Note**: This library is ready for use with manual code (see examples). The code generator will automate what's currently written by hand.
