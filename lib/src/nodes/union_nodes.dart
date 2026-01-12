import 'tree_node.dart';

/// Represents a node that can be one of two types.
///
/// Union types allow expressing "either/or" relationships in the tree structure
/// while maintaining type safety.
@Deprecated('Use generated union node classes instead. Union types now generate concrete classes with semantic constructor names.')
class UnionNode2<T1 extends TreeNode, T2 extends TreeNode> extends TreeNode {
  final TreeNode _value;

  UnionNode2._(this._value, {super.id});

  /// Creates a union node with the first type.
  factory UnionNode2.first(T1 value, {String? id}) {
    return UnionNode2._(value, id: id);
  }

  /// Creates a union node with the second type.
  factory UnionNode2.second(T2 value, {String? id}) {
    return UnionNode2._(value, id: id);
  }

  /// Returns true if this union contains the first type.
  bool get isFirst => _value is T1;

  /// Returns true if this union contains the second type.
  bool get isSecond => _value is T2;

  /// Gets the value as the first type, or null if it's not that type.
  T1? get asFirst => isFirst ? _value as T1 : null;

  /// Gets the value as the second type, or null if it's not that type.
  T2? get asSecond => isSecond ? _value as T2 : null;

  /// Gets the underlying value.
  TreeNode get value => _value;

  /// Pattern matching helper.
  T when<T>({required T Function(T1) first, required T Function(T2) second}) {
    if (isFirst) {
      return first(_value as T1);
    } else {
      return second(_value as T2);
    }
  }

  @override
  UnionNode2<T1, T2> clone() {
    final clonedValue = _value.clone();
    if (clonedValue is T1) {
      return UnionNode2.first(clonedValue);
    } else {
      return UnionNode2.second(clonedValue as T2);
    }
  }

  @override
  T accept<T>(TreeNodeVisitor<T> visitor) => _value.accept(visitor);

  @override
  String toString() => 'UnionNode2<$T1,$T2>($_value)';
}

/// Represents a node that can be one of three types.
@Deprecated('Use generated union node classes instead. Union types now generate concrete classes with semantic constructor names.')
class UnionNode3<T1 extends TreeNode, T2 extends TreeNode, T3 extends TreeNode> extends TreeNode {
  final TreeNode _value;

  UnionNode3._(this._value, {super.id});

  /// Creates a union node with the first type.
  factory UnionNode3.first(T1 value, {String? id}) {
    return UnionNode3._(value, id: id);
  }

  /// Creates a union node with the second type.
  factory UnionNode3.second(T2 value, {String? id}) {
    return UnionNode3._(value, id: id);
  }

  /// Creates a union node with the third type.
  factory UnionNode3.third(T3 value, {String? id}) {
    return UnionNode3._(value, id: id);
  }

  /// Returns true if this union contains the first type.
  bool get isFirst => _value is T1;

  /// Returns true if this union contains the second type.
  bool get isSecond => _value is T2;

  /// Returns true if this union contains the third type.
  bool get isThird => _value is T3;

  /// Gets the value as the first type, or null if it's not that type.
  T1? get asFirst => isFirst ? _value as T1 : null;

  /// Gets the value as the second type, or null if it's not that type.
  T2? get asSecond => isSecond ? _value as T2 : null;

  /// Gets the value as the third type, or null if it's not that type.
  T3? get asThird => isThird ? _value as T3 : null;

  /// Gets the underlying value.
  TreeNode get value => _value;

  /// Pattern matching helper.
  T when<T>({required T Function(T1) first, required T Function(T2) second, required T Function(T3) third}) {
    if (isFirst) {
      return first(_value as T1);
    } else if (isSecond) {
      return second(_value as T2);
    } else {
      return third(_value as T3);
    }
  }

  @override
  UnionNode3<T1, T2, T3> clone() {
    final clonedValue = _value.clone();
    if (clonedValue is T1) {
      return UnionNode3.first(clonedValue);
    } else if (clonedValue is T2) {
      return UnionNode3.second(clonedValue);
    } else {
      return UnionNode3.third(clonedValue as T3);
    }
  }

  @override
  T accept<T>(TreeNodeVisitor<T> visitor) => _value.accept(visitor);

  @override
  String toString() => 'UnionNode3<$T1,$T2,$T3>($_value)';
}

/// Represents a node that can be one of four types.
@Deprecated('Use generated union node classes instead. Union types now generate concrete classes with semantic constructor names.')
class UnionNode4<T1 extends TreeNode, T2 extends TreeNode, T3 extends TreeNode, T4 extends TreeNode> extends TreeNode {
  final TreeNode _value;

  UnionNode4._(this._value, {super.id});

  /// Creates a union node with the first type.
  factory UnionNode4.first(T1 value, {String? id}) {
    return UnionNode4._(value, id: id);
  }

  /// Creates a union node with the second type.
  factory UnionNode4.second(T2 value, {String? id}) {
    return UnionNode4._(value, id: id);
  }

  /// Creates a union node with the third type.
  factory UnionNode4.third(T3 value, {String? id}) {
    return UnionNode4._(value, id: id);
  }

  /// Creates a union node with the fourth type.
  factory UnionNode4.fourth(T4 value, {String? id}) {
    return UnionNode4._(value, id: id);
  }

  /// Returns true if this union contains the first type.
  bool get isFirst => _value is T1;

  /// Returns true if this union contains the second type.
  bool get isSecond => _value is T2;

  /// Returns true if this union contains the third type.
  bool get isThird => _value is T3;

  /// Returns true if this union contains the fourth type.
  bool get isFourth => _value is T4;

  /// Gets the value as the first type, or null if it's not that type.
  T1? get asFirst => isFirst ? _value as T1 : null;

  /// Gets the value as the second type, or null if it's not that type.
  T2? get asSecond => isSecond ? _value as T2 : null;

  /// Gets the value as the third type, or null if it's not that type.
  T3? get asThird => isThird ? _value as T3 : null;

  /// Gets the value as the fourth type, or null if it's not that type.
  T4? get asFourth => isFourth ? _value as T4 : null;

  /// Gets the underlying value.
  TreeNode get value => _value;

  /// Pattern matching helper.
  T when<T>({
    required T Function(T1) first,
    required T Function(T2) second,
    required T Function(T3) third,
    required T Function(T4) fourth,
  }) {
    if (isFirst) {
      return first(_value as T1);
    } else if (isSecond) {
      return second(_value as T2);
    } else if (isThird) {
      return third(_value as T3);
    } else {
      return fourth(_value as T4);
    }
  }

  @override
  UnionNode4<T1, T2, T3, T4> clone() {
    final clonedValue = _value.clone();
    if (clonedValue is T1) {
      return UnionNode4.first(clonedValue);
    } else if (clonedValue is T2) {
      return UnionNode4.second(clonedValue);
    } else if (clonedValue is T3) {
      return UnionNode4.third(clonedValue);
    } else {
      return UnionNode4.fourth(clonedValue as T4);
    }
  }

  @override
  T accept<T>(TreeNodeVisitor<T> visitor) => _value.accept(visitor);

  @override
  String toString() => 'UnionNode4<$T1,$T2,$T3,$T4>($_value)';
}
