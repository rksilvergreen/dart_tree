// GENERATED CODE - DO NOT MODIFY BY HAND
// Generated from union_test_schema.dart

import 'package:dart_tree/dart_tree.dart';

/// Generated union node class for StringOrInt
class StringOrIntNode extends TreeNode {
  final TreeNode _value;

  StringOrIntNode._(this._value, {super.id});

  /// Creates a StringOrInt node with a StringValueNode value.
  factory StringOrIntNode.string(StringValueNode value, {String? id}) {
    return StringOrIntNode._(value, id: id);
  }

  /// Creates a StringOrInt node with a IntValueNode value.
  factory StringOrIntNode.integer(IntValueNode value, {String? id}) {
    return StringOrIntNode._(value, id: id);
  }

  /// Returns true if this union contains a StringValueNode.
  bool get isString => _value is StringValueNode;

  /// Returns true if this union contains a IntValueNode.
  bool get isInteger => _value is IntValueNode;

  /// Gets the value as StringValueNode, or null if it's not that type.
  StringValueNode? get asString => isString ? _value as StringValueNode : null;

  /// Gets the value as IntValueNode, or null if it's not that type.
  IntValueNode? get asInteger => isInteger ? _value as IntValueNode : null;

  /// Gets the underlying value.
  TreeNode get value => _value;

  /// Pattern matching helper.
  T when<T>({required T Function(StringValueNode) string, required T Function(IntValueNode) integer}) {
    if (isString) {
      return string(_value as StringValueNode);
    } else {
      return integer(_value as IntValueNode);
    }
  }

  @override
  StringOrIntNode clone() {
    final clonedValue = _value.clone();
    if (clonedValue is StringValueNode) {
      return StringOrIntNode.string(clonedValue);
    } else {
      return StringOrIntNode.integer(clonedValue);
    }
  }

  @override
  T accept<T>(TreeNodeVisitor<T> visitor) => _value.accept(visitor);

  @override
  String toString() => 'StringOrIntNode($_value)';
}
