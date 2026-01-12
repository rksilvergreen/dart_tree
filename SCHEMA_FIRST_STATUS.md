# Schema-First Code Generation Status

## Overview

This document tracks the implementation status of the schema-first code generation feature, which allows users to define schemas using `$Schema` classes and automatically generates both TreeObject and TreeNode classes.

## Completed Work ✅

### 1. Core Infrastructure
- **[schema_info.dart](dart_tree_gen/lib/src/schema/schema_info.dart)**: Data structures for schema metadata
  - `SchemaInfo`: Represents analyzed schema structure
  - `PropertyInfo`: Property metadata and constraints
  - `ValidationConstraints`: Validation rules storage
  - `SchemaType` enum: Type classification

- **[schema_analyzer.dart](dart_tree_gen/lib/src/schema/schema_analyzer.dart)**: Schema analysis engine
  - Finds `@jsonSchema` annotated variables
  - Extracts properties, constraints, and references
  - Builds dependency graph
  - Handles inline `$Object` definitions

### 2. Code Generators
- **[tree_object_class_generator.dart](dart_tree_gen/lib/src/generators/tree_object_class_generator.dart)**
  - Generates TreeObject classes with proper field types
  - Creates constructors with validation
  - Implements `toJson()` and `toYaml()` methods
  - Implements `fromJson()` and `fromYaml()` factories

- **[tree_node_class_generator.dart](dart_tree_gen/lib/src/generators/tree_node_class_generator.dart)**
  - Generates TreeNode classes with type-safe getters
  - Creates value setters for primitive types with validation
  - Implements `clone()` method

- **[validation_code_generator.dart](dart_tree_gen/lib/src/validation/validation_code_generator.dart)**
  - Generates string validation (minLength, maxLength, pattern)
  - Generates number validation (minimum, maximum, multipleOf)
  - Generates array validation (minItems, maxItems, uniqueItems)

- **[schema_based_generator.dart](dart_tree_gen/lib/src/schema_based_generator.dart)**
  - Main generator coordinating all code generation
  - Creates unified Tree class with `objectToNode` implementation
  - Handles all schema types

### 3. Annotations & Integration
- **[@jsonSchema annotation](dart_tree/lib/src/annotations.dart)**: Marks schema variables for code generation
- **[build.yaml](dart_tree_gen/build.yaml)**: Builder configuration for schema-first generation
- **[builder.dart](dart_tree_gen/lib/builder.dart)**: Build integration with `schemaBuilder`

### 4. Example Schema
- **[blog_post.dart](dart_tree/example_new/blog_post.dart)**: Working example with:
  - BlogPost schema with required fields
  - Comment schema
  - User and Admin schemas
  - Proper use of `@jsonSchema` annotation

## Current Issues 🔧

### Analyzer API Compatibility
The main blocker is that `analyzer` version 7.x introduced breaking API changes:
- `Element` → `Element2`
- `LibraryElement` → `LibraryElement2`
- Elements now use fragments (`element.firstFragment`)
- Methods like `computeConstantValue()` moved

**Impact**: The build script fails to compile due to type mismatches between old (`Element`) and new (`Element2`) APIs.

**Required Fix**: Update `schema_analyzer.dart` to use the new Element2 API throughout:
```dart
// Old API (analyzer 6.x)
for (final element in library.topLevelElements) {
  if (element is! TopLevelVariableElement) continue;
  final value = element.computeConstantValue();
}

// New API (analyzer 7.x) - needs implementation
for (final element in library.allElements) {
  final fragment = element.firstFragment;
  // Need to determine correct fragment type and methods
}
```

### Missing Export
- Fixed: Changed `union_object.dart` → `union_objects.dart` in exports

## Architecture Design ✅

The implementation follows the approved plan:

```
User Schema (@jsonSchema)
    ↓
SchemaAnalyzer
    ↓
SchemaInfo objects
    ↓
Code Generators → Generated .g.dart file
    - TreeObject classes (with validation & serialization)
    - TreeNode classes (with getters & setters)
    - Unified Tree class (with objectToNode)
```

### Example Generated Code Structure

For a schema like:
```dart
@jsonSchema
final blogPost = $Object(
  title: 'BlogPost',
  required: ['title'],
  properties: {
    'title': $String(minLength: 1, maxLength: 100),
    'author': $String(),
  },
);
```

The generator creates:
```dart
// TreeObject with validation
class BlogPostObject extends TreeObject {
  final StringValue title;
  final StringValue? author;
  
  BlogPostObject({required this.title, this.author}) {
    if (title.value.length < 1 || title.value.length > 100) {
      throw ArgumentError('title must be 1-100 characters');
    }
  }
  
  String toJson() { /* ... */ }
  String toYaml() { /* ... */ }
  static BlogPostObject fromJson(String json) { /* ... */ }
  static BlogPostObject fromYaml(String yaml) { /* ... */ }
}

// TreeNode with setters
class BlogPostNode extends CollectionNode {
  StringValueNode get title => $children!['title'] as StringValueNode;
  StringValueNode? get author => $children?['author'] as StringValueNode?;
  
  set title(String value) {
    if (value.length < 1 || value.length > 100) {
      throw ArgumentError('title must be 1-100 characters');
    }
    $children!['title'] = StringValueNode(StringValue(value));
  }
  
  set author(String? value) { /* ... */ }
  
  @override
  BlogPostNode clone() => BlogPostNode(id: id);
}

// Unified Tree
class GeneratedTree extends Tree {
  GeneratedTree({required super.root});
  
  (TreeNode, List<(Edge, Object)>)? objectToNode(Object object) {
    if (object is BlogPostObject) {
      return (BlogPostNode(), [
        (Edge(StringValueNode, 'title'), object.title),
        if (object.author != null) (Edge(StringValueNode, 'author'), object.author!),
      ]);
    }
    // ... handle other types
  }
}
```

## Remaining Work 📋

### High Priority
1. **Fix Analyzer API Compatibility** (BLOCKER)
   - Update `schema_analyzer.dart` to use Element2 API
   - Update `tree_object_analyzer.dart` (legacy generator) if needed
   - Test that build compiles successfully

2. **Array/List Support**
   - Implement list object/node generation for `$Array` schemas
   - Handle array item types properly
   - Generate custom ListObject subclasses

3. **Schema References**
   - Ensure referenced schemas are properly linked
   - Handle forward references
   - Generate dependency-ordered code

### Medium Priority
4. **Union Type Support**
   - Implement `$Union` schema handling
   - Generate UnionObject2/3/4 typedefs
   - Create factory extension methods

5. **MapObject Support**
   - Determine what schema construct maps to MapObject
   - Implement map generation

6. **Testing**
   - Create unit tests for schema analyzer
   - Create integration tests for code generation
   - Test validation enforcement
   - Test serialization round-trips

### Low Priority
7. **Documentation**
   - Migration guide from @treeObject to $Schema
   - API documentation for schema classes
   - Examples demonstrating all features

8. **Optimization**
   - Improve generated code formatting
   - Add code comments to generated classes
   - Optimize validation code generation

## Next Steps

1. **Immediate**: Fix the analyzer API compatibility issue
   - Research Element2 API in analyzer 7.x documentation
   - Update schema_analyzer.dart systematically
   - Test build compilation

2. **After Build Works**: Run generation on blog_post.dart example
   - Verify generated code structure
   - Test that generated classes compile
   - Make adjustments to generators as needed

3. **Iterate**: Add missing features incrementally
   - Start with array support (most needed)
   - Add comprehensive tests
   - Refine based on real usage

## Dependencies

- `analyzer: ^7.0.0` (requires Element2 API updates)
- `source_gen: ^3.0.0` (requires analyzer 7.x)
- `build: ^3.0.0`
- `code_builder: ^4.11.0`

## References

- Original Plan: `cursor-plan://2919a9a1-34d9-481a-ae2f-b11710615822/dart.plan.md`
- Example Schema: `example_new/blog_post.dart`
- Schema Classes: `lib/src/schema/schema.dart`

