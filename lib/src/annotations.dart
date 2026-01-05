/// Annotation marking a class for tree code generation.
/// 
/// Classes annotated with @treeObject will have:
/// - A corresponding TreeNode class generated
/// - Conversion logic in the user's Tree subclass
/// 
/// Example:
/// ```dart
/// @treeObject
/// class Operation extends TreeObject {
///   final StringValue? operationId;
///   final RequestBody requestBody;
///   
///   Operation({this.operationId, required this.requestBody});
/// }
/// ```
class TreeObject {
  const TreeObject();
}

/// Short alias for @TreeObject().
const treeObject = TreeObject();

/// Annotation marking a field as a tree child.
/// 
/// Fields annotated with @TreeChild() will:
/// - Be stored as child nodes in the tree
/// - Have type-safe getters in the generated TreeNode class
/// - Support tree navigation and operations
/// 
/// If a field is nullable, it automatically becomes optional (no separate annotation needed).
/// 
/// Example:
/// ```dart
/// @treeObject
/// class Operation extends TreeObject {
///   final StringValue? operationId;  // Scalar field (not a child)
///   
///   @TreeChild()
///   final RequestBody? requestBody;  // Optional tree child
///   
///   @TreeChild()
///   final Responses responses;  // Required tree child
/// }
/// ```
class TreeChild {
  const TreeChild();
}

/// Short alias for @TreeChild().
const treeChild = TreeChild();

/// Annotation marking a class for generating a Tree extension.
/// 
/// The generator will create an extension on your Tree class with the objectToNode
/// conversion logic for all @treeObject classes in the project.
/// 
/// Your tree class should be non-abstract and extend Tree.
/// 
/// Example:
/// ```dart
/// @GenerateTree()
/// class MyDomainTree extends Tree {
///   MyDomainTree({required super.root});
/// }
/// ```
class GenerateTree {
  /// Optional name for the generated extension.
  /// If null, uses the annotated class name with 'Extension' suffix.
  final String? name;

  const GenerateTree({this.name});
}

/// Short alias for @GenerateTree().
const generateTree = GenerateTree();

