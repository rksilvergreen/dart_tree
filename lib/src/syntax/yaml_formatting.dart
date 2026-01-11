/// YAML-specific formatting and style metadata.
///
/// This metadata preserves the exact formatting of YAML source files
/// to enable lossless roundtripping. YAML has significantly more
/// syntactic variation than JSON.

import 'json_formatting.dart'; // For LineEnding enum

/// YAML collection style (block vs flow).
enum YamlCollectionStyle {
  /// Block style with indentation:
  /// ```yaml
  /// - item1
  /// - item2
  /// ```
  block,

  /// Flow style with brackets/braces:
  /// ```yaml
  /// [item1, item2]
  /// ```
  flow,
}

/// YAML string quote style.
enum YamlStringQuoteStyle {
  /// Single-quoted: 'string'
  single,

  /// Double-quoted: "string"
  double_,

  /// Unquoted (plain): string
  none,

  /// Literal block scalar: |
  literal,

  /// Folded block scalar: >
  folded,
}

/// YAML block scalar chomping indicator.
enum YamlBlockChomping {
  /// Strip final line breaks: |-, >-
  strip,

  /// Clip to single final line break: |, > (default)
  clip,

  /// Keep all final line breaks: |+, >+
  keep,
}

/// YAML number format.
enum YamlNumberFormat {
  /// Decimal: 123, 45.67
  decimal,

  /// Hexadecimal: 0xFF
  hex,

  /// Octal: 0o177
  octal,

  /// Binary: 0b1010
  binary,

  /// Exponential: 1.23e5
  exponential,

  /// Special floats: .inf, -.inf, .nan
  specialFloat,
}

/// Formatting information for YAML nodes.
///
/// Preserves whitespace, indentation, collection style, and tags.
class YamlFormattingInfo {
  /// Collection style (block vs flow) for mappings and sequences.
  final YamlCollectionStyle? collectionStyle;

  /// The indentation string (always spaces in YAML, tabs not allowed).
  final String? indentation;

  /// The level of indentation for this node.
  final int? indentationLevel;

  /// Line ending style (LF, CRLF).
  final LineEnding? lineEnding;

  /// Explicit type tag (e.g., '!!timestamp', '!mytype').
  final String? tag;

  const YamlFormattingInfo({
    this.collectionStyle,
    this.indentation,
    this.indentationLevel,
    this.lineEnding,
    this.tag,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is YamlFormattingInfo &&
          collectionStyle == other.collectionStyle &&
          indentation == other.indentation &&
          indentationLevel == other.indentationLevel &&
          lineEnding == other.lineEnding &&
          tag == other.tag;

  @override
  int get hashCode => Object.hash(
        collectionStyle,
        indentation,
        indentationLevel,
        lineEnding,
        tag,
      );
}

/// Style metadata for YAML string values.
class YamlStringStyle {
  /// The quote style used for this string.
  final YamlStringQuoteStyle quoteStyle;

  /// Block chomping indicator for literal/folded scalars.
  final YamlBlockChomping? chomping;

  /// Explicit indentation indicator for block scalars (e.g., |2).
  final int? blockIndent;

  /// The original string representation.
  final String? originalRepresentation;

  const YamlStringStyle({
    required this.quoteStyle,
    this.chomping,
    this.blockIndent,
    this.originalRepresentation,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is YamlStringStyle &&
          quoteStyle == other.quoteStyle &&
          chomping == other.chomping &&
          blockIndent == other.blockIndent &&
          originalRepresentation == other.originalRepresentation;

  @override
  int get hashCode => Object.hash(
        quoteStyle,
        chomping,
        blockIndent,
        originalRepresentation,
      );
}

/// Style metadata for YAML number values.
class YamlNumberStyle {
  /// The format used for this number.
  final YamlNumberFormat format;

  /// Whether underscores are used for readability (e.g., 1_000_000).
  final bool? hasUnderscores;

  /// The original representation (e.g., "0xFF", "1_000").
  final String? originalRepresentation;

  /// Number of decimal places for floats (e.g., 2 for "1.00").
  final int? decimalPlaces;

  const YamlNumberStyle({
    required this.format,
    this.hasUnderscores,
    this.originalRepresentation,
    this.decimalPlaces,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is YamlNumberStyle &&
          format == other.format &&
          hasUnderscores == other.hasUnderscores &&
          originalRepresentation == other.originalRepresentation &&
          decimalPlaces == other.decimalPlaces;

  @override
  int get hashCode => Object.hash(
        format,
        hasUnderscores,
        originalRepresentation,
        decimalPlaces,
      );
}

/// Style metadata for YAML boolean values.
///
/// YAML allows multiple representations for true/false.
class YamlBoolStyle {
  /// The exact representation used (e.g., "true", "yes", "on", "YES").
  final String representation;

  const YamlBoolStyle({required this.representation});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is YamlBoolStyle && representation == other.representation;

  @override
  int get hashCode => representation.hashCode;
}

/// Style metadata for YAML null values.
///
/// YAML allows multiple representations for null.
class YamlNullStyle {
  /// The exact representation used (e.g., "null", "~", or empty).
  final String representation;

  const YamlNullStyle({required this.representation});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is YamlNullStyle && representation == other.representation;

  @override
  int get hashCode => representation.hashCode;
}

/// Style metadata for YAML sequences (arrays).
class YamlSequenceStyle {
  /// Collection style (block vs flow).
  final YamlCollectionStyle style;

  /// Dash position for block sequences (inline vs separate line).
  final bool? dashOnSameLine;

  const YamlSequenceStyle({
    required this.style,
    this.dashOnSameLine,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is YamlSequenceStyle &&
          style == other.style &&
          dashOnSameLine == other.dashOnSameLine;

  @override
  int get hashCode => Object.hash(style, dashOnSameLine);
}

/// Style metadata for YAML mappings (objects).
class YamlMappingStyle {
  /// Collection style (block vs flow).
  final YamlCollectionStyle style;

  /// Whether to use explicit key indicator (?) for complex keys.
  final bool? explicitKey;

  /// Property order (to preserve original order).
  final List<String>? propertyOrder;

  const YamlMappingStyle({
    required this.style,
    this.explicitKey,
    this.propertyOrder,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is YamlMappingStyle &&
          style == other.style &&
          explicitKey == other.explicitKey &&
          _listsEqual(propertyOrder, other.propertyOrder);

  @override
  int get hashCode => Object.hash(style, explicitKey, propertyOrder);

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

