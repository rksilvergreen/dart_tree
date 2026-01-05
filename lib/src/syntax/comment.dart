/// Comment representation and positioning.
///
/// Comments are stored at the Tree level and associated with specific nodes
/// to enable centralized management and easy querying.

import 'source_position.dart';

/// Position of a comment relative to its associated node.
enum CommentPosition {
  /// Comment appears before the node.
  before,

  /// Comment appears after the node on the same line (inline).
  endOfLine,

  /// Comment appears after the node on a new line.
  after,
}

/// Represents a comment in the source file.
class Comment {
  /// The content of the comment (without comment markers like # or //).
  final String content;

  /// The position of the comment relative to its associated node.
  final CommentPosition position;

  /// The source range where this comment appears in the original file.
  final SourceRange? sourceRange;

  const Comment({
    required this.content,
    required this.position,
    this.sourceRange,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Comment &&
          content == other.content &&
          position == other.position &&
          sourceRange == other.sourceRange;

  @override
  int get hashCode => Object.hash(content, position, sourceRange);

  @override
  String toString() => 'Comment($position: $content)';
}

/// A comment entry that associates a comment with a specific node.
///
/// Used when retrieving all comments from a tree in document order.
class CommentEntry {
  /// The ID of the node this comment is associated with.
  final String nodeId;

  /// The comment itself.
  final Comment comment;

  /// The position of the comment in the source (from comment.sourceRange.start).
  SourcePosition get position =>
      comment.sourceRange?.start ??
      const SourcePosition(line: 0, column: 0, offset: 0);

  const CommentEntry({
    required this.nodeId,
    required this.comment,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CommentEntry &&
          nodeId == other.nodeId &&
          comment == other.comment;

  @override
  int get hashCode => Object.hash(nodeId, comment);

  @override
  String toString() => 'CommentEntry(node: $nodeId, $comment)';
}

