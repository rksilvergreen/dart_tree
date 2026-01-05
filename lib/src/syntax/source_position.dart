/// Represents a position in a source file.
/// 
/// Used to track the location of nodes when parsing from JSON/YAML,
/// enabling accurate error reporting and preservation of source locations.
class SourcePosition {
  /// The 1-based line number in the source file.
  final int line;

  /// The 1-based column number in the source file.
  final int column;

  /// The 0-based byte offset from the start of the file.
  final int offset;

  const SourcePosition({
    required this.line,
    required this.column,
    required this.offset,
  });

  @override
  String toString() => '$line:$column (offset: $offset)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SourcePosition &&
          line == other.line &&
          column == other.column &&
          offset == other.offset;

  @override
  int get hashCode => Object.hash(line, column, offset);
}

/// Represents a range in a source file with start and end positions.
class SourceRange {
  /// The starting position of this range.
  final SourcePosition start;

  /// The ending position of this range.
  final SourcePosition end;

  const SourceRange({
    required this.start,
    required this.end,
  });

  @override
  String toString() => '$start - $end';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SourceRange && start == other.start && end == other.end;

  @override
  int get hashCode => Object.hash(start, end);
}

