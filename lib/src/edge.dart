/// Represents an edge in the tree graph connecting a parent to a child.
///
/// Edges are identified by both the type of the child node and a string key
/// (property name for objects, index for arrays).
class Edge {
  /// The expected type of the child node.
  final Type type;

  /// The key identifying this edge (property name or array index).
  final String key;

  const Edge(this.type, this.key);

  @override
  int get hashCode => Object.hash(type, key);

  @override
  bool operator ==(Object other) => identical(this, other) || other is Edge && type == other.type && key == other.key;

  @override
  String toString() => 'Edge($type, "$key")';
}
