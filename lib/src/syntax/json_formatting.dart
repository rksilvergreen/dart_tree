/// JSON-specific formatting and style metadata.
///
/// This metadata preserves the exact formatting of JSON source files
/// to enable lossless roundtripping.

/// Line ending style.
enum LineEnding {
  /// Line Feed (Unix/Linux/Mac)
  lf,

  /// Carriage Return + Line Feed (Windows)
  crlf,

  /// Carriage Return (old Mac)
  cr,
}

/// JSON number format style.
enum JsonNumberFormat {
  /// Standard decimal notation: 123, 45.67
  decimal,

  /// Scientific notation: 1.23e5
  scientific,
}

/// Formatting information for JSON nodes.
///
/// Preserves whitespace, indentation, and layout choices.
class JsonFormattingInfo {
  /// The indentation style (spaces or tabs).
  final String? indentation;

  /// The level of indentation for this node.
  final int? indentationLevel;

  /// Whitespace before the node (before opening bracket/brace).
  final String? whitespaceBefore;

  /// Whitespace after the node (after closing bracket/brace).
  final String? whitespaceAfter;

  /// Line ending style (LF, CRLF).
  final LineEnding? lineEnding;

  /// Whether this collection is on a single line vs multiline.
  final bool? singleLine;

  const JsonFormattingInfo({
    this.indentation,
    this.indentationLevel,
    this.whitespaceBefore,
    this.whitespaceAfter,
    this.lineEnding,
    this.singleLine,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is JsonFormattingInfo &&
          indentation == other.indentation &&
          indentationLevel == other.indentationLevel &&
          whitespaceBefore == other.whitespaceBefore &&
          whitespaceAfter == other.whitespaceAfter &&
          lineEnding == other.lineEnding &&
          singleLine == other.singleLine;

  @override
  int get hashCode =>
      Object.hash(indentation, indentationLevel, whitespaceBefore, whitespaceAfter, lineEnding, singleLine);
}

/// Style metadata for JSON string values.
class JsonStringStyle {
  /// Always true for valid JSON (strings must be double-quoted).
  final bool doubleQuoted;

  /// Map of character positions to their escape sequences.
  /// Example: {5: '\\n', 10: '\\t'}
  final Map<int, String>? escapeSequences;

  /// The original string representation before unescaping.
  /// Useful for preserving exact formatting.
  final String? originalRepresentation;

  const JsonStringStyle({this.doubleQuoted = true, this.escapeSequences, this.originalRepresentation});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is JsonStringStyle &&
          doubleQuoted == other.doubleQuoted &&
          _mapsEqual(escapeSequences, other.escapeSequences) &&
          originalRepresentation == other.originalRepresentation;

  @override
  int get hashCode => Object.hash(doubleQuoted, escapeSequences, originalRepresentation);

  static bool _mapsEqual(Map<int, String>? a, Map<int, String>? b) {
    if (a == null && b == null) return true;
    if (a == null || b == null) return false;
    if (a.length != b.length) return false;
    for (final key in a.keys) {
      if (a[key] != b[key]) return false;
    }
    return true;
  }
}

/// Style metadata for JSON number values.
class JsonNumberStyle {
  /// The format used for this number.
  final JsonNumberFormat format;

  /// Number of decimal places for floats (e.g., 2 for "1.00").
  final int? decimalPlaces;

  /// Whether this is negative zero (-0).
  final bool? negativeZero;

  /// The original representation (e.g., "1.0" vs "1.00").
  final String? originalRepresentation;

  const JsonNumberStyle({
    this.format = JsonNumberFormat.decimal,
    this.decimalPlaces,
    this.negativeZero,
    this.originalRepresentation,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is JsonNumberStyle &&
          format == other.format &&
          decimalPlaces == other.decimalPlaces &&
          negativeZero == other.negativeZero &&
          originalRepresentation == other.originalRepresentation;

  @override
  int get hashCode => Object.hash(format, decimalPlaces, negativeZero, originalRepresentation);
}

/// Style metadata for JSON arrays.
class JsonArrayStyle {
  /// Whether this array is on a single line.
  final bool? singleLine;

  /// Whitespace before opening bracket.
  final String? whitespaceBefore;

  /// Whitespace after opening bracket.
  final String? whitespaceAfterOpen;

  /// Whitespace before closing bracket.
  final String? whitespaceBeforeClose;

  /// Whitespace after closing bracket.
  final String? whitespaceAfter;

  const JsonArrayStyle({
    this.singleLine,
    this.whitespaceBefore,
    this.whitespaceAfterOpen,
    this.whitespaceBeforeClose,
    this.whitespaceAfter,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is JsonArrayStyle &&
          singleLine == other.singleLine &&
          whitespaceBefore == other.whitespaceBefore &&
          whitespaceAfterOpen == other.whitespaceAfterOpen &&
          whitespaceBeforeClose == other.whitespaceBeforeClose &&
          whitespaceAfter == other.whitespaceAfter;

  @override
  int get hashCode =>
      Object.hash(singleLine, whitespaceBefore, whitespaceAfterOpen, whitespaceBeforeClose, whitespaceAfter);
}

/// Style metadata for JSON objects.
class JsonObjectStyle {
  /// Whether this object is on a single line.
  final bool? singleLine;

  /// Whitespace before opening brace.
  final String? whitespaceBefore;

  /// Whitespace after opening brace.
  final String? whitespaceAfterOpen;

  /// Whitespace before closing brace.
  final String? whitespaceBeforeClose;

  /// Whitespace after closing brace.
  final String? whitespaceAfter;

  /// Property order (to preserve original order).
  final List<String>? propertyOrder;

  const JsonObjectStyle({
    this.singleLine,
    this.whitespaceBefore,
    this.whitespaceAfterOpen,
    this.whitespaceBeforeClose,
    this.whitespaceAfter,
    this.propertyOrder,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is JsonObjectStyle &&
          singleLine == other.singleLine &&
          whitespaceBefore == other.whitespaceBefore &&
          whitespaceAfterOpen == other.whitespaceAfterOpen &&
          whitespaceBeforeClose == other.whitespaceBeforeClose &&
          whitespaceAfter == other.whitespaceAfter &&
          _listsEqual(propertyOrder, other.propertyOrder);

  @override
  int get hashCode => Object.hash(
    singleLine,
    whitespaceBefore,
    whitespaceAfterOpen,
    whitespaceBeforeClose,
    whitespaceAfter,
    propertyOrder,
  );

  static bool _listsEqual(List<String>? a, List<String>? b) {
    if (a == null && b == null) return true;
    if (a == null || b == null) return false;
    if (a.length != b.length) return false;
    for (int i = 0; i < a.length; i++) {
      if (a[i] != b[i]) return false;
    }
    return true;
  }
}
