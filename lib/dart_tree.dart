/// A library for representing, traversing, and manipulating tree structures.
///
/// Users define domain objects (TreeObject classes) and the code generator
/// creates corresponding TreeNode classes and conversion logic automatically.
///
/// Key concepts:
/// - **TreeObject**: User-defined domain objects (data model)
/// - **TreeNode**: Generated tree-aware counterparts (for navigation)
/// - **Tree**: Abstract container that users subclass (via generation)
/// - **ValueObject**: Built-in types like StringValue, IntValue, etc.
///
/// Example:
/// ```dart
/// @treeObject
/// class Operation extends TreeObject {
///   final StringValue? operationId;
///
///   @TreeChild()
///   final RequestBody? requestBody;
/// }
///
/// // Generated: MyDomainTree extends Tree
/// final tree = MyDomainTree(root: Operation(...));
/// ```
library dart_tree;

// Core domain types
export 'src/objects/tree_object.dart';
export 'src/objects/value_objects.dart';
export 'src/objects/list_object.dart';
export 'src/objects/map_object.dart';
export 'src/objects/union_objects.dart';

// Annotations
export 'src/annotations.dart' hide TreeObject;

// Schema definitions
export 'src/schema/schema.dart';

// Core node types
export 'src/nodes/tree_node.dart' hide ValueNode;
export 'src/nodes/value_nodes.dart';
export 'src/nodes/map_tree_node.dart';
export 'src/nodes/list_tree_node.dart';
export 'src/nodes/union_nodes.dart';

// Syntax metadata
export 'src/syntax/source_position.dart';
export 'src/syntax/json_formatting.dart';
export 'src/syntax/yaml_formatting.dart';
export 'src/syntax/comment.dart';

// Tree management
export 'src/tree.dart';
export 'src/edge.dart';
export 'src/tree_node_record.dart';

// Operations
export 'src/operations/traversal.dart';
export 'src/operations/mutation.dart';
export 'src/operations/query.dart';

// I/O
export 'src/io/tree_object_json_decoder.dart';
export 'src/io/tree_object_yaml_decoder.dart';
export 'src/io/parsing_utils.dart';

// Utilities
export 'src/utils/pointer.dart';
