import 'tree_object.dart';
import '../syntax/json_formatting.dart';
import '../syntax/yaml_formatting.dart';
import '../syntax/source_position.dart';

/// Base class for value objects that hold primitive data.
///
/// Value objects are leaf nodes in the tree with no children.
abstract class ValueObject<T> extends TreeObject {
  /// The semantic value.
  final T value;

  const ValueObject(this.value, {super.sourceRange, super.jsonFormatting, super.yamlFormatting});

  @override
  String toString() => '${runtimeType}($value)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is ValueObject<T> && runtimeType == other.runtimeType && value == other.value;

  @override
  int get hashCode => Object.hash(runtimeType, value);
}

/// String value object.
///
/// When parsing from JSON/YAML, formatting and style metadata can be preserved
/// by passing optional parameters to `fromJson`/`fromYaml`. This enables
/// lossless round-tripping.
class StringValue extends ValueObject<String> {
  /// JSON-specific string styling (quote style, escape sequences, etc.).
  final JsonStringStyle? jsonStringStyle;

  /// YAML-specific string styling (quote style, block scalars, etc.).
  final YamlStringStyle? yamlStringStyle;

  const StringValue(
    super.value, {
    super.sourceRange,
    super.jsonFormatting,
    super.yamlFormatting,
    this.jsonStringStyle,
    this.yamlStringStyle,
  });

  @override
  String toJson() {
    // Use original representation if available
    if (jsonStringStyle?.originalRepresentation != null) {
      return jsonStringStyle!.originalRepresentation!;
    }

    // Otherwise encode with escaping
    final buffer = StringBuffer('"');
    for (int i = 0; i < value.length; i++) {
      final char = value[i];

      // Check if there's a custom escape sequence for this position
      if (jsonStringStyle?.escapeSequences?.containsKey(i) == true) {
        buffer.write(jsonStringStyle!.escapeSequences![i]);
        continue;
      }

      // Standard escaping
      switch (char) {
        case '"':
          buffer.write(r'\"');
          break;
        case '\\':
          buffer.write(r'\\');
          break;
        case '\b':
          buffer.write(r'\b');
          break;
        case '\f':
          buffer.write(r'\f');
          break;
        case '\n':
          buffer.write(r'\n');
          break;
        case '\r':
          buffer.write(r'\r');
          break;
        case '\t':
          buffer.write(r'\t');
          break;
        default:
          buffer.write(char);
      }
    }
    buffer.write('"');
    return buffer.toString();
  }

  @override
  String toYaml() {
    // Use original representation if available
    if (yamlStringStyle?.originalRepresentation != null) {
      return yamlStringStyle!.originalRepresentation!;
    }

    // Encode based on quote style
    switch (yamlStringStyle?.quoteStyle) {
      case YamlStringQuoteStyle.single:
        return "'${value.replaceAll("'", "''")}'";
      case YamlStringQuoteStyle.double_:
        final escaped = value
            .replaceAll('\\', '\\\\')
            .replaceAll('"', '\\"')
            .replaceAll('\n', '\\n')
            .replaceAll('\r', '\\r')
            .replaceAll('\t', '\\t');
        return '"$escaped"';
      case YamlStringQuoteStyle.literal:
        final buffer = StringBuffer('|');
        if (yamlStringStyle?.chomping != null) {
          switch (yamlStringStyle!.chomping!) {
            case YamlBlockChomping.strip:
              buffer.write('-');
              break;
            case YamlBlockChomping.keep:
              buffer.write('+');
              break;
            case YamlBlockChomping.clip:
              break;
          }
        }
        if (yamlStringStyle?.blockIndent != null) {
          buffer.write(yamlStringStyle!.blockIndent);
        }
        buffer.writeln();
        for (final line in value.split('\n')) {
          buffer.writeln('  $line');
        }
        return buffer.toString();
      case YamlStringQuoteStyle.folded:
        final buffer = StringBuffer('>');
        if (yamlStringStyle?.chomping != null) {
          switch (yamlStringStyle!.chomping!) {
            case YamlBlockChomping.strip:
              buffer.write('-');
              break;
            case YamlBlockChomping.keep:
              buffer.write('+');
              break;
            case YamlBlockChomping.clip:
              break;
          }
        }
        if (yamlStringStyle?.blockIndent != null) {
          buffer.write(yamlStringStyle!.blockIndent);
        }
        buffer.writeln();
        for (final line in value.split('\n')) {
          buffer.writeln('  $line');
        }
        return buffer.toString();
      case YamlStringQuoteStyle.none:
      case null:
        // Plain (unquoted) string
        return value;
    }
  }

  /// Parses a JSON string representation and extracts formatting metadata.
  ///
  /// Input should be the raw JSON string with quotes, e.g., `"\"hello\""`
  static StringValue fromJson(String jsonString) {
    jsonString = jsonString.trim();

    if (jsonString.isEmpty) {
      throw FormatException('Empty JSON string');
    }

    // JSON strings must be double-quoted
    if (!jsonString.startsWith('"') || !jsonString.endsWith('"')) {
      throw FormatException('JSON string must be double-quoted', jsonString);
    }

    final originalRepresentation = jsonString;
    final escapeSequences = <int, String>{};
    final buffer = StringBuffer();

    // Parse the string content (skip opening and closing quotes)
    int pos = 1;
    int valuePos = 0; // Position in the decoded value

    while (pos < jsonString.length - 1) {
      final char = jsonString[pos];

      if (char == '\\') {
        // Escape sequence
        if (pos + 1 >= jsonString.length - 1) {
          throw FormatException('Incomplete escape sequence', jsonString, pos);
        }

        final nextChar = jsonString[pos + 1];
        final escapeStart = pos;

        switch (nextChar) {
          case '"':
            buffer.write('"');
            escapeSequences[valuePos] = '\\"';
            pos += 2;
            break;
          case '\\':
            buffer.write('\\');
            escapeSequences[valuePos] = '\\\\';
            pos += 2;
            break;
          case '/':
            buffer.write('/');
            escapeSequences[valuePos] = '\\/';
            pos += 2;
            break;
          case 'b':
            buffer.write('\b');
            escapeSequences[valuePos] = '\\b';
            pos += 2;
            break;
          case 'f':
            buffer.write('\f');
            escapeSequences[valuePos] = '\\f';
            pos += 2;
            break;
          case 'n':
            buffer.write('\n');
            escapeSequences[valuePos] = '\\n';
            pos += 2;
            break;
          case 'r':
            buffer.write('\r');
            escapeSequences[valuePos] = '\\r';
            pos += 2;
            break;
          case 't':
            buffer.write('\t');
            escapeSequences[valuePos] = '\\t';
            pos += 2;
            break;
          case 'u':
            // Unicode escape sequence \uXXXX
            if (pos + 5 >= jsonString.length) {
              throw FormatException('Incomplete unicode escape', jsonString, pos);
            }
            final hexCode = jsonString.substring(pos + 2, pos + 6);
            final codeUnit = int.tryParse(hexCode, radix: 16);
            if (codeUnit == null) {
              throw FormatException('Invalid unicode escape', jsonString, pos);
            }
            buffer.writeCharCode(codeUnit);
            escapeSequences[valuePos] = '\\u$hexCode';
            pos += 6;
            break;
          default:
            throw FormatException('Invalid escape sequence: \\$nextChar', jsonString, pos);
        }
        valuePos++;
      } else {
        buffer.write(char);
        pos++;
        valuePos++;
      }
    }

    return StringValue(
      buffer.toString(),
      jsonStringStyle: JsonStringStyle(
        originalRepresentation: originalRepresentation,
        escapeSequences: escapeSequences.isNotEmpty ? escapeSequences : null,
      ),
    );
  }

  /// Parses a YAML string representation and extracts formatting metadata.
  ///
  /// Input can be quoted (single/double), plain, or block scalar (literal/folded)
  static StringValue fromYaml(String yamlString) {
    yamlString = yamlString.trim();

    if (yamlString.isEmpty) {
      return StringValue('', yamlStringStyle: YamlStringStyle(quoteStyle: YamlStringQuoteStyle.none));
    }

    final firstChar = yamlString[0];

    // Double-quoted string
    if (firstChar == '"') {
      return _parseYamlDoubleQuotedString(yamlString);
    }

    // Single-quoted string
    if (firstChar == "'") {
      return _parseYamlSingleQuotedString(yamlString);
    }

    // Block scalar (literal or folded)
    if (firstChar == '|' || firstChar == '>') {
      return _parseYamlBlockScalar(yamlString);
    }

    // Plain (unquoted) string
    return StringValue(
      yamlString,
      yamlStringStyle: YamlStringStyle(quoteStyle: YamlStringQuoteStyle.none, originalRepresentation: yamlString),
    );
  }

  static StringValue _parseYamlDoubleQuotedString(String yamlString) {
    if (!yamlString.endsWith('"')) {
      throw FormatException('Unterminated double-quoted string', yamlString);
    }

    final buffer = StringBuffer();
    int pos = 1; // Skip opening quote

    while (pos < yamlString.length - 1) {
      final char = yamlString[pos];

      if (char == '\\') {
        if (pos + 1 >= yamlString.length - 1) {
          throw FormatException('Incomplete escape sequence', yamlString, pos);
        }

        final nextChar = yamlString[pos + 1];
        switch (nextChar) {
          case '"':
            buffer.write('"');
            pos += 2;
            break;
          case '\\':
            buffer.write('\\');
            pos += 2;
            break;
          case 'n':
            buffer.write('\n');
            pos += 2;
            break;
          case 'r':
            buffer.write('\r');
            pos += 2;
            break;
          case 't':
            buffer.write('\t');
            pos += 2;
            break;
          default:
            buffer.write(nextChar);
            pos += 2;
        }
      } else {
        buffer.write(char);
        pos++;
      }
    }

    return StringValue(
      buffer.toString(),
      yamlStringStyle: YamlStringStyle(quoteStyle: YamlStringQuoteStyle.double_, originalRepresentation: yamlString),
    );
  }

  static StringValue _parseYamlSingleQuotedString(String yamlString) {
    if (!yamlString.endsWith("'")) {
      throw FormatException('Unterminated single-quoted string', yamlString);
    }

    final buffer = StringBuffer();
    int pos = 1; // Skip opening quote

    while (pos < yamlString.length - 1) {
      final char = yamlString[pos];

      if (char == "'") {
        // Check for escaped single quote ('')
        if (pos + 1 < yamlString.length - 1 && yamlString[pos + 1] == "'") {
          buffer.write("'");
          pos += 2;
        } else {
          // Unexpected single quote in the middle
          throw FormatException('Unexpected single quote', yamlString, pos);
        }
      } else {
        buffer.write(char);
        pos++;
      }
    }

    return StringValue(
      buffer.toString(),
      yamlStringStyle: YamlStringStyle(quoteStyle: YamlStringQuoteStyle.single, originalRepresentation: yamlString),
    );
  }

  static StringValue _parseYamlBlockScalar(String yamlString) {
    final isLiteral = yamlString[0] == '|';
    final isFolded = yamlString[0] == '>';

    if (!isLiteral && !isFolded) {
      throw FormatException('Expected block scalar indicator', yamlString);
    }

    // Parse header line (e.g., |+2, >-, etc.)
    int pos = 1;
    YamlBlockChomping? chomping;
    int? blockIndent;

    while (pos < yamlString.length && yamlString[pos] != '\n' && yamlString[pos] != '\r') {
      final char = yamlString[pos];
      if (char == '+') {
        chomping = YamlBlockChomping.keep;
      } else if (char == '-') {
        chomping = YamlBlockChomping.strip;
      } else if (char >= '0' && char <= '9') {
        blockIndent = int.parse(char);
      }
      pos++;
    }

    // Skip newline after header
    if (pos < yamlString.length && yamlString[pos] == '\r') pos++;
    if (pos < yamlString.length && yamlString[pos] == '\n') pos++;

    // Extract the block content
    final content = yamlString.substring(pos);

    // For now, return the content as-is (proper block scalar processing would normalize indentation)
    // In a full implementation, we'd process the indentation and folding rules

    return StringValue(
      content.trimRight(),
      yamlStringStyle: YamlStringStyle(
        quoteStyle: isLiteral ? YamlStringQuoteStyle.literal : YamlStringQuoteStyle.folded,
        originalRepresentation: yamlString,
        chomping: chomping,
        blockIndent: blockIndent,
      ),
    );
  }
}

/// Integer value object.
class IntValue extends ValueObject<int> {
  /// JSON-specific number styling (decimal vs scientific notation, etc.).
  final JsonNumberStyle? jsonNumberStyle;

  /// YAML-specific number styling (hex, octal, binary, etc.).
  final YamlNumberStyle? yamlNumberStyle;

  const IntValue(
    super.value, {
    super.sourceRange,
    super.jsonFormatting,
    super.yamlFormatting,
    this.jsonNumberStyle,
    this.yamlNumberStyle,
  });

  @override
  String toJson() {
    // Use original representation if available
    if (jsonNumberStyle?.originalRepresentation != null) {
      return jsonNumberStyle!.originalRepresentation!;
    }

    // Check for negative zero
    if (value == 0 && jsonNumberStyle?.negativeZero == true) {
      return '-0';
    }

    // Format based on style
    if (jsonNumberStyle?.format == JsonNumberFormat.scientific) {
      return value.toStringAsExponential(jsonNumberStyle?.decimalPlaces);
    }
    return value.toString();
  }

  @override
  String toYaml() {
    // Use original representation if available
    if (yamlNumberStyle?.originalRepresentation != null) {
      return yamlNumberStyle!.originalRepresentation!;
    }

    // Format based on style
    if (yamlNumberStyle?.format != null) {
      switch (yamlNumberStyle!.format) {
        case YamlNumberFormat.hex:
          return '0x${value.toRadixString(16)}';
        case YamlNumberFormat.octal:
          return '0o${value.toRadixString(8)}';
        case YamlNumberFormat.binary:
          return '0b${value.toRadixString(2)}';
        case YamlNumberFormat.exponential:
          return value.toStringAsExponential();
        case YamlNumberFormat.decimal:
          return value.toString();
        case YamlNumberFormat.specialFloat:
          return value.toString(); // Integers don't have special float values
      }
    }
    return value.toString();
  }

  /// Parses a JSON number string and extracts formatting metadata.
  ///
  /// Input should be the raw number string, e.g., `"42"`, `"-123"`, `"1e10"`
  static IntValue fromJson(String jsonString) {
    jsonString = jsonString.trim();

    if (jsonString.isEmpty) {
      throw FormatException('Empty JSON number');
    }

    // JSON numbers are always decimal (no hex/octal/binary)
    final value = int.tryParse(jsonString);
    if (value == null) {
      throw FormatException('Invalid JSON integer', jsonString);
    }

    // Detect if exponential notation was used
    final hasExponent = jsonString.contains('e') || jsonString.contains('E');

    return IntValue(
      value,
      jsonNumberStyle: JsonNumberStyle(originalRepresentation: jsonString, isExponential: hasExponent),
    );
  }

  /// Parses a YAML number string and extracts formatting metadata.
  ///
  /// Input can be decimal, hex (`0xFF`), octal (`0o77`), or binary (`0b1010`)
  static IntValue fromYaml(String yamlString) {
    yamlString = yamlString.trim();

    if (yamlString.isEmpty) {
      throw FormatException('Empty YAML number');
    }

    final originalRepresentation = yamlString;
    YamlNumberFormat format = YamlNumberFormat.decimal;
    int value;

    // Detect format and parse accordingly
    if (yamlString.startsWith('0x') || yamlString.startsWith('0X')) {
      // Hexadecimal
      format = YamlNumberFormat.hex;
      value = int.parse(yamlString.substring(2), radix: 16);
    } else if (yamlString.startsWith('0o') || yamlString.startsWith('0O')) {
      // Octal
      format = YamlNumberFormat.octal;
      value = int.parse(yamlString.substring(2), radix: 8);
    } else if (yamlString.startsWith('0b') || yamlString.startsWith('0B')) {
      // Binary
      format = YamlNumberFormat.binary;
      value = int.parse(yamlString.substring(2), radix: 2);
    } else if (yamlString.contains('e') || yamlString.contains('E')) {
      // Exponential notation
      format = YamlNumberFormat.exponential;
      value = double.parse(yamlString).toInt();
    } else {
      // Decimal
      value = int.parse(yamlString);
    }

    return IntValue(
      value,
      yamlNumberStyle: YamlNumberStyle(format: format, originalRepresentation: originalRepresentation),
    );
  }
}

/// Double value object.
class DoubleValue extends ValueObject<double> {
  /// JSON-specific number styling (decimal places, scientific notation, etc.).
  final JsonNumberStyle? jsonNumberStyle;

  /// YAML-specific number styling (special floats like .inf, .nan, etc.).
  final YamlNumberStyle? yamlNumberStyle;

  const DoubleValue(
    super.value, {
    super.sourceRange,
    super.jsonFormatting,
    super.yamlFormatting,
    this.jsonNumberStyle,
    this.yamlNumberStyle,
  });

  @override
  String toJson() {
    // Use original representation if available
    if (jsonNumberStyle?.originalRepresentation != null) {
      return jsonNumberStyle!.originalRepresentation!;
    }

    // Check for negative zero
    if (value == 0 && jsonNumberStyle?.negativeZero == true) {
      return '-0';
    }

    // Format based on style
    if (jsonNumberStyle?.format == JsonNumberFormat.scientific) {
      return value.toStringAsExponential(jsonNumberStyle?.decimalPlaces);
    }
    return value.toString();
  }

  @override
  String toYaml() {
    // Use original representation if available
    if (yamlNumberStyle?.originalRepresentation != null) {
      return yamlNumberStyle!.originalRepresentation!;
    }

    // Format based on style - handle special float values
    if (yamlNumberStyle?.format == YamlNumberFormat.specialFloat) {
      if (value.isNaN) {
        return '.nan';
      } else if (value.isInfinite) {
        return value.isNegative ? '-.inf' : '.inf';
      }
    }

    if (yamlNumberStyle?.format == YamlNumberFormat.exponential) {
      return value.toStringAsExponential();
    }

    return value.toString();
  }

  /// Parses a JSON number string and extracts formatting metadata.
  ///
  /// Input should be the raw number string, e.g., `"3.14"`, `"1.5e10"`
  static DoubleValue fromJson(String jsonString) {
    jsonString = jsonString.trim();

    if (jsonString.isEmpty) {
      throw FormatException('Empty JSON number');
    }

    final value = double.tryParse(jsonString);
    if (value == null) {
      throw FormatException('Invalid JSON number', jsonString);
    }

    // Detect if exponential notation was used
    final hasExponent = jsonString.contains('e') || jsonString.contains('E');

    // Count decimal places (if not exponential)
    int? decimalPlaces;
    if (!hasExponent && jsonString.contains('.')) {
      final parts = jsonString.split('.');
      if (parts.length == 2) {
        decimalPlaces = parts[1].length;
      }
    }

    return DoubleValue(
      value,
      jsonNumberStyle: JsonNumberStyle(
        originalRepresentation: jsonString,
        isExponential: hasExponent,
        decimalPlaces: decimalPlaces,
      ),
    );
  }

  /// Parses a YAML number string and extracts formatting metadata.
  ///
  /// Input can be decimal, exponential, or special floats (`.inf`, `.nan`)
  static DoubleValue fromYaml(String yamlString) {
    yamlString = yamlString.trim();

    if (yamlString.isEmpty) {
      throw FormatException('Empty YAML number');
    }

    final originalRepresentation = yamlString;
    YamlNumberFormat format = YamlNumberFormat.decimal;
    double value;

    // Check for special float values
    final lowerCase = yamlString.toLowerCase();
    if (lowerCase == '.inf' || lowerCase == '+.inf') {
      format = YamlNumberFormat.specialFloat;
      value = double.infinity;
    } else if (lowerCase == '-.inf') {
      format = YamlNumberFormat.specialFloat;
      value = double.negativeInfinity;
    } else if (lowerCase == '.nan') {
      format = YamlNumberFormat.specialFloat;
      value = double.nan;
    } else if (yamlString.contains('e') || yamlString.contains('E')) {
      // Exponential notation
      format = YamlNumberFormat.exponential;
      value = double.parse(yamlString);
    } else {
      // Decimal
      value = double.parse(yamlString);
    }

    // Count decimal places (if decimal format)
    int? decimalPlaces;
    if (format == YamlNumberFormat.decimal && yamlString.contains('.')) {
      final parts = yamlString.split('.');
      if (parts.length == 2) {
        decimalPlaces = parts[1].length;
      }
    }

    return DoubleValue(
      value,
      yamlNumberStyle: YamlNumberStyle(
        format: format,
        originalRepresentation: originalRepresentation,
        decimalPlaces: decimalPlaces,
      ),
    );
  }
}

/// Boolean value object.
class BoolValue extends ValueObject<bool> {
  /// YAML-specific bool styling (true/yes/on, false/no/off variations).
  /// JSON booleans are always "true" or "false", so no JSON style needed.
  final YamlBoolStyle? yamlBoolStyle;

  const BoolValue(super.value, {super.sourceRange, super.jsonFormatting, super.yamlFormatting, this.yamlBoolStyle});

  @override
  String toJson() => value ? 'true' : 'false';

  @override
  String toYaml() => yamlBoolStyle?.representation ?? (value ? 'true' : 'false');

  /// Parses a JSON boolean string.
  ///
  /// Input should be `"true"` or `"false"`
  static BoolValue fromJson(String jsonString) {
    jsonString = jsonString.trim();

    if (jsonString == 'true') {
      return BoolValue(true);
    } else if (jsonString == 'false') {
      return BoolValue(false);
    } else {
      throw FormatException('Invalid JSON boolean', jsonString);
    }
  }

  /// Parses a YAML boolean string.
  ///
  /// Input can be: `true`, `false`, `yes`, `no`, `on`, `off`, `y`, `n`, etc.
  static BoolValue fromYaml(String yamlString) {
    yamlString = yamlString.trim();
    final lowerCase = yamlString.toLowerCase();

    bool value;
    if (lowerCase == 'true' || lowerCase == 'yes' || lowerCase == 'on' || lowerCase == 'y') {
      value = true;
    } else if (lowerCase == 'false' || lowerCase == 'no' || lowerCase == 'off' || lowerCase == 'n') {
      value = false;
    } else {
      throw FormatException('Invalid YAML boolean', yamlString);
    }

    return BoolValue(value, yamlBoolStyle: YamlBoolStyle(representation: yamlString));
  }
}

/// Null value object.
class NullValue extends ValueObject<Null> {
  /// YAML-specific null styling (null/~/empty variations).
  /// JSON null is always "null", so no JSON style needed.
  final YamlNullStyle? yamlNullStyle;

  const NullValue({super.sourceRange, super.jsonFormatting, super.yamlFormatting, this.yamlNullStyle}) : super(null);

  @override
  String toJson() => 'null';

  @override
  String toYaml() => yamlNullStyle?.representation ?? 'null';

  /// Parses a JSON null string.
  ///
  /// Input should be `"null"`
  static NullValue fromJson(String jsonString) {
    jsonString = jsonString.trim();

    if (jsonString == 'null') {
      return const NullValue();
    } else {
      throw FormatException('Invalid JSON null', jsonString);
    }
  }

  /// Parses a YAML null string.
  ///
  /// Input can be: `null`, `~`, `Null`, `NULL`, or empty string
  static NullValue fromYaml(String yamlString) {
    yamlString = yamlString.trim();
    final lowerCase = yamlString.toLowerCase();

    if (lowerCase == 'null' || yamlString == '~' || yamlString.isEmpty) {
      return NullValue(yamlNullStyle: YamlNullStyle(representation: yamlString.isEmpty ? '' : yamlString));
    } else {
      throw FormatException('Invalid YAML null', yamlString);
    }
  }
}
