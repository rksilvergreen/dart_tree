// GENERATED CODE - DO NOT MODIFY BY HAND
// Generated from union_test_schema.dart

import 'package:dart_tree/dart_tree.dart';

/// Generated union node class for MixedValue
class MixedValueNode extends TreeNode {
  final TreeNode _value;

  MixedValueNode._(this._value, {super.id});

  /// Creates a MixedValue node with a StringValueNode value.
  factory MixedValueNode.string(StringValueNode value, {String? id}) {
    return MixedValueNode._(value, id: id);
  }

  /// Creates a MixedValue node with a IntValueNode value.
  factory MixedValueNode.integer(IntValueNode value, {String? id}) {
    return MixedValueNode._(value, id: id);
  }

  /// Creates a MixedValue node with a BoolValueNode value.
  factory MixedValueNode.boolean(BoolValueNode value, {String? id}) {
    return MixedValueNode._(value, id: id);
  }

  /// Returns true if this union contains a StringValueNode.
  bool get isString => _value is StringValueNode;

  /// Returns true if this union contains a IntValueNode.
  bool get isInteger => _value is IntValueNode;

  /// Returns true if this union contains a BoolValueNode.
  bool get isBoolean => _value is BoolValueNode;

  /// Gets the value as StringValueNode, or null if it's not that type.
  StringValueNode? get asString => isString ? _value as StringValueNode : null;

  /// Gets the value as IntValueNode, or null if it's not that type.
  IntValueNode? get asInteger => isInteger ? _value as IntValueNode : null;

  /// Gets the value as BoolValueNode, or null if it's not that type.
  BoolValueNode? get asBoolean => isBoolean ? _value as BoolValueNode : null;

  /// Gets the underlying value.
  TreeNode get value => _value;

  /// Pattern matching helper.
  T when<T>({required T Function(StringValueNode) string, required T Function(IntValueNode) integer, required T Function(BoolValueNode) boolean}) {
    if (isString) {
      return string(_value as StringValueNode);
    } else if (isInteger) {
      return integer(_value as IntValueNode);
    } else {
      return boolean(_value as BoolValueNode);
    }
  }

  @override
  MixedValueNode clone() {
    final clonedValue = _value.clone();
    if (clonedValue is StringValueNode) {
      return MixedValueNode.string(clonedValue);
    } else if (clonedValue is IntValueNode) {
      return MixedValueNode.integer(clonedValue);
    } else {
      return MixedValueNode.boolean(clonedValue);
    }
  }

  @override
  T accept<T>(TreeNodeVisitor<T> visitor) => _value.accept(visitor);

  @override
  String toString() => 'MixedValueNode($_value)';
}
