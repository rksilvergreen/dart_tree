import '../nodes/tree_node.dart';
import '../tree.dart';
import '../utils/pointer.dart';

/// Extension providing mutation operations on Tree.
/// 
/// These operations modify the tree in place (mutable operations).
/// For immutable operations, use clone() first.
extension TreeMutation on Tree {
  /// Updates a node at the specified path in place.
  /// 
  /// If the path doesn't exist, throws a StateError.
  /// The new node must be of the same type as the existing node.
  void updateAt(String pointer, TreeNode newNode) {
    final existingNode = getNodeByPath(pointer);
    if (existingNode == null) {
      throw StateError('No node found at path: $pointer');
    }

    if (existingNode.runtimeType != newNode.runtimeType) {
      throw StateError(
          'Type mismatch: cannot replace ${existingNode.runtimeType} with ${newNode.runtimeType}');
    }

    // Get parent and key
    final parentPointer = Pointer.parent(pointer);
    final key = Pointer.lastSegment(pointer);

    if (parentPointer == null || key == null) {
      // Updating root
      replaceTree(Tree(root: newNode));
    } else {
      final parent = getNodeByPath(parentPointer);
      if (parent == null) {
        throw StateError('Parent not found at path: $parentPointer');
      }

      // Remove old subtree and add new one
      removeSubtree(existingNode);
      setChild(parent: parent, key: key, child: newNode);
    }
  }

  /// Deletes the node at the specified path.
  /// 
  /// Returns the deleted subtree, or null if the path doesn't exist.
  Tree? deleteAt(String pointer) {
    final node = getNodeByPath(pointer);
    if (node == null) return null;

    return removeSubtree(node);
  }

  /// Inserts or updates a node at the specified path.
  /// 
  /// If the path exists, replaces the existing node.
  /// If the path doesn't exist but the parent exists, adds the node.
  /// Throws if the parent doesn't exist.
  void setAt(String pointer, TreeNode newNode) {
    if (pointer == '/') {
      // Replace root
      replaceTree(Tree(root: newNode));
      return;
    }

    final existingNode = getNodeByPath(pointer);
    if (existingNode != null) {
      // Update existing
      updateAt(pointer, newNode);
      return;
    }

    // Insert new
    final parentPointer = Pointer.parent(pointer);
    final key = Pointer.lastSegment(pointer);

    if (parentPointer == null || key == null) {
      throw StateError('Invalid pointer: $pointer');
    }

    final parent = getNodeByPath(parentPointer);
    if (parent == null) {
      throw StateError('Parent not found at path: $parentPointer');
    }

    setChild(parent: parent, key: key, child: newNode);
  }

  /// Creates an immutable copy with the node at the specified path replaced.
  /// 
  /// This is an immutable operation - returns a new tree with the change applied.
  Tree replaceAt(String pointer, TreeNode newNode) {
    final cloned = clone();
    cloned.updateAt(pointer, newNode);
    return cloned;
  }

  /// Creates an immutable copy with the node at the specified path deleted.
  Tree withoutAt(String pointer) {
    final cloned = clone();
    cloned.deleteAt(pointer);
    return cloned;
  }

  /// Creates an immutable copy with a node inserted or updated at the specified path.
  Tree withAt(String pointer, TreeNode newNode) {
    final cloned = clone();
    cloned.setAt(pointer, newNode);
    return cloned;
  }

  /// Applies a transformation function to a node and updates it in place.
  void transformAt(String pointer, TreeNode Function(TreeNode) transform) {
    final node = getNodeByPath(pointer);
    if (node == null) {
      throw StateError('No node found at path: $pointer');
    }

    final transformed = transform(node);
    updateAt(pointer, transformed);
  }

  /// Creates an immutable copy with a transformation applied to a node.
  Tree withTransformAt(
      String pointer, TreeNode Function(TreeNode) transform) {
    final cloned = clone();
    cloned.transformAt(pointer, transform);
    return cloned;
  }

  /// Moves a subtree from one location to another (mutable operation).
  void move(String fromPointer, String toPointer) {
    if (fromPointer == toPointer) return;

    final node = getNodeByPath(fromPointer);
    if (node == null) {
      throw StateError('No node found at source path: $fromPointer');
    }

    // Remove from source
    final subtree = removeSubtree(node);
    final root = subtree.root;
    if (root == null) {
      throw StateError('Removed subtree has no root');
    }

    // Insert at destination
    if (toPointer == '/') {
      replaceTree(subtree);
    } else {
      final parentPointer = Pointer.parent(toPointer);
      final key = Pointer.lastSegment(toPointer);

      if (parentPointer == null || key == null) {
        throw StateError('Invalid destination pointer: $toPointer');
      }

      final parent = getNodeByPath(parentPointer);
      if (parent == null) {
        throw StateError('Parent not found at destination: $parentPointer');
      }

      setChild(parent: parent, key: key, child: root);
    }
  }

  /// Creates an immutable copy with a subtree moved from one location to another.
  Tree withMove(String fromPointer, String toPointer) {
    final cloned = clone();
    cloned.move(fromPointer, toPointer);
    return cloned;
  }

  /// Copies a subtree from one location to another (mutable operation).
  void copy(String fromPointer, String toPointer) {
    if (fromPointer == toPointer) return;

    final node = getNodeByPath(fromPointer);
    if (node == null) {
      throw StateError('No node found at source path: $fromPointer');
    }

    // Clone the subtree
    final subtree = removeSubtree(node);
    final clonedSubtree = subtree.clone();

    // Put back the original
    final root = subtree.root;
    if (root != null) {
      final parentPointer = Pointer.parent(fromPointer);
      final key = Pointer.lastSegment(fromPointer);

      if (parentPointer != null && key != null) {
        final parent = getNodeByPath(parentPointer);
        if (parent != null) {
          setChild(parent: parent, key: key, child: root);
        }
      }
    }

    // Insert the clone at destination
    final clonedRoot = clonedSubtree.root;
    if (clonedRoot == null) {
      throw StateError('Cloned subtree has no root');
    }

    if (toPointer == '/') {
      replaceTree(clonedSubtree);
    } else {
      final parentPointer = Pointer.parent(toPointer);
      final key = Pointer.lastSegment(toPointer);

      if (parentPointer == null || key == null) {
        throw StateError('Invalid destination pointer: $toPointer');
      }

      final parent = getNodeByPath(parentPointer);
      if (parent == null) {
        throw StateError('Parent not found at destination: $parentPointer');
      }

      setChild(parent: parent, key: key, child: clonedRoot);
    }
  }

  /// Creates an immutable copy with a subtree copied from one location to another.
  Tree withCopy(String fromPointer, String toPointer) {
    final cloned = clone();
    cloned.copy(fromPointer, toPointer);
    return cloned;
  }
}

