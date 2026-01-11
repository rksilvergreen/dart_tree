/// Utilities for parsing JSON and YAML strings while preserving formatting.
///
/// These functions extract value strings from JSON/YAML source, maintaining
/// the original representation for lossless round-tripping.
library;

/// Result of parsing a JSON/YAML value with position tracking.
class ParseResult {
  /// The extracted string representation of the value.
  final String value;
  
  /// The position where this value ends in the source (exclusive).
  final int endPosition;
  
  const ParseResult(this.value, this.endPosition);
}

/// Skips whitespace characters and returns the position of the first non-whitespace character.
int skipWhitespace(String input, int start) {
  while (start < input.length && _isWhitespace(input.codeUnitAt(start))) {
    start++;
  }
  return start;
}

bool _isWhitespace(int codeUnit) {
  return codeUnit == 0x20 || // space
      codeUnit == 0x09 || // tab
      codeUnit == 0x0A || // newline
      codeUnit == 0x0D; // carriage return
}

/// Parses a JSON string value starting at the given position.
/// Returns the full string representation (including quotes) and end position.
ParseResult parseJsonString(String input, int start) {
  start = skipWhitespace(input, start);
  
  if (start >= input.length || input[start] != '"') {
    throw FormatException('Expected opening quote', input, start);
  }
  
  final buffer = StringBuffer();
  buffer.write('"');
  int pos = start + 1;
  
  while (pos < input.length) {
    final char = input[pos];
    buffer.write(char);
    
    if (char == '\\') {
      // Escape sequence - include next character
      pos++;
      if (pos < input.length) {
        buffer.write(input[pos]);
      }
    } else if (char == '"') {
      // End of string
      return ParseResult(buffer.toString(), pos + 1);
    }
    pos++;
  }
  
  throw FormatException('Unterminated string', input, start);
}

/// Parses a JSON number starting at the given position.
/// Returns the number string and end position.
ParseResult parseJsonNumber(String input, int start) {
  start = skipWhitespace(input, start);
  
  final buffer = StringBuffer();
  int pos = start;
  
  // Optional minus
  if (pos < input.length && input[pos] == '-') {
    buffer.write(input[pos++]);
  }
  
  // Digits
  if (pos >= input.length || !_isDigit(input.codeUnitAt(pos))) {
    throw FormatException('Expected digit', input, pos);
  }
  
  // Integer part
  while (pos < input.length && _isDigit(input.codeUnitAt(pos))) {
    buffer.write(input[pos++]);
  }
  
  // Optional decimal part
  if (pos < input.length && input[pos] == '.') {
    buffer.write(input[pos++]);
    while (pos < input.length && _isDigit(input.codeUnitAt(pos))) {
      buffer.write(input[pos++]);
    }
  }
  
  // Optional exponent
  if (pos < input.length && (input[pos] == 'e' || input[pos] == 'E')) {
    buffer.write(input[pos++]);
    if (pos < input.length && (input[pos] == '+' || input[pos] == '-')) {
      buffer.write(input[pos++]);
    }
    while (pos < input.length && _isDigit(input.codeUnitAt(pos))) {
      buffer.write(input[pos++]);
    }
  }
  
  return ParseResult(buffer.toString(), pos);
}

bool _isDigit(int codeUnit) {
  return codeUnit >= 0x30 && codeUnit <= 0x39; // 0-9
}

/// Parses a JSON boolean starting at the given position.
/// Returns "true" or "false" and end position.
ParseResult parseJsonBool(String input, int start) {
  start = skipWhitespace(input, start);
  
  if (input.startsWith('true', start)) {
    return ParseResult('true', start + 4);
  } else if (input.startsWith('false', start)) {
    return ParseResult('false', start + 5);
  }
  
  throw FormatException('Expected boolean', input, start);
}

/// Parses a JSON null starting at the given position.
/// Returns "null" and end position.
ParseResult parseJsonNull(String input, int start) {
  start = skipWhitespace(input, start);
  
  if (input.startsWith('null', start)) {
    return ParseResult('null', start + 4);
  }
  
  throw FormatException('Expected null', input, start);
}

/// Parses a JSON value (any type) starting at the given position.
/// Returns the value string and end position.
ParseResult parseJsonValue(String input, int start) {
  start = skipWhitespace(input, start);
  
  if (start >= input.length) {
    throw FormatException('Unexpected end of input', input, start);
  }
  
  final char = input[start];
  
  if (char == '"') {
    return parseJsonString(input, start);
  } else if (char == '{') {
    return parseJsonObject(input, start);
  } else if (char == '[') {
    return parseJsonArray(input, start);
  } else if (char == 't' || char == 'f') {
    return parseJsonBool(input, start);
  } else if (char == 'n') {
    return parseJsonNull(input, start);
  } else if (char == '-' || _isDigit(char.codeUnitAt(0))) {
    return parseJsonNumber(input, start);
  }
  
  throw FormatException('Unexpected character: $char', input, start);
}

/// Parses a JSON object and returns the full object string and end position.
ParseResult parseJsonObject(String input, int start) {
  start = skipWhitespace(input, start);
  
  if (start >= input.length || input[start] != '{') {
    throw FormatException('Expected opening brace', input, start);
  }
  
  int pos = start + 1;
  int braceDepth = 1;
  
  while (pos < input.length && braceDepth > 0) {
    final char = input[pos];
    
    if (char == '"') {
      // Skip string content
      final stringResult = parseJsonString(input, pos);
      pos = stringResult.endPosition;
    } else if (char == '{') {
      braceDepth++;
      pos++;
    } else if (char == '}') {
      braceDepth--;
      pos++;
    } else {
      pos++;
    }
  }
  
  if (braceDepth != 0) {
    throw FormatException('Unterminated object', input, start);
  }
  
  return ParseResult(input.substring(start, pos), pos);
}

/// Parses a JSON array and returns the full array string and end position.
ParseResult parseJsonArray(String input, int start) {
  start = skipWhitespace(input, start);
  
  if (start >= input.length || input[start] != '[') {
    throw FormatException('Expected opening bracket', input, start);
  }
  
  int pos = start + 1;
  int bracketDepth = 1;
  
  while (pos < input.length && bracketDepth > 0) {
    final char = input[pos];
    
    if (char == '"') {
      // Skip string content
      final stringResult = parseJsonString(input, pos);
      pos = stringResult.endPosition;
    } else if (char == '[') {
      bracketDepth++;
      pos++;
    } else if (char == ']') {
      bracketDepth--;
      pos++;
    } else {
      pos++;
    }
  }
  
  if (bracketDepth != 0) {
    throw FormatException('Unterminated array', input, start);
  }
  
  return ParseResult(input.substring(start, pos), pos);
}

/// Extracts field strings from a JSON object.
/// Returns a map of field names to their string representations.
Map<String, String> extractJsonObjectFields(String json) {
  json = json.trim();
  
  if (!json.startsWith('{') || !json.endsWith('}')) {
    throw FormatException('Expected JSON object');
  }
  
  final result = <String, String>{};
  int pos = 1; // Skip opening brace
  
  while (pos < json.length - 1) {
    pos = skipWhitespace(json, pos);
    
    if (pos >= json.length - 1) break;
    if (json[pos] == '}') break;
    if (json[pos] == ',') {
      pos++;
      continue;
    }
    
    // Parse key
    final keyResult = parseJsonString(json, pos);
    final key = keyResult.value.substring(1, keyResult.value.length - 1); // Remove quotes
    pos = skipWhitespace(json, keyResult.endPosition);
    
    // Expect colon
    if (pos >= json.length || json[pos] != ':') {
      throw FormatException('Expected colon after key', json, pos);
    }
    pos = skipWhitespace(json, pos + 1);
    
    // Parse value
    final valueResult = parseJsonValue(json, pos);
    result[key] = valueResult.value;
    pos = valueResult.endPosition;
  }
  
  return result;
}

/// Extracts element strings from a JSON array.
/// Returns a list of element string representations.
List<String> extractJsonArrayElements(String json) {
  json = json.trim();
  
  if (!json.startsWith('[') || !json.endsWith(']')) {
    throw FormatException('Expected JSON array');
  }
  
  final result = <String>[];
  int pos = 1; // Skip opening bracket
  
  while (pos < json.length - 1) {
    pos = skipWhitespace(json, pos);
    
    if (pos >= json.length - 1) break;
    if (json[pos] == ']') break;
    if (json[pos] == ',') {
      pos++;
      continue;
    }
    
    // Parse element
    final elementResult = parseJsonValue(json, pos);
    result.add(elementResult.value);
    pos = elementResult.endPosition;
  }
  
  return result;
}

// ============================================================================
// YAML Parsing Utilities
// ============================================================================

/// Parses a YAML string value.
/// Can be quoted (single/double), plain, or block scalar (literal/folded).
ParseResult parseYamlString(String input, int start) {
  start = skipWhitespace(input, start);
  
  if (start >= input.length) {
    throw FormatException('Unexpected end of input', input, start);
  }
  
  final char = input[start];
  
  // Quoted string (double)
  if (char == '"') {
    return _parseYamlDoubleQuotedString(input, start);
  }
  
  // Quoted string (single)
  if (char == "'") {
    return _parseYamlSingleQuotedString(input, start);
  }
  
  // Block scalar (literal or folded)
  if (char == '|' || char == '>') {
    return _parseYamlBlockScalar(input, start);
  }
  
  // Plain string (unquoted)
  return _parseYamlPlainString(input, start);
}

ParseResult _parseYamlDoubleQuotedString(String input, int start) {
  final buffer = StringBuffer();
  buffer.write('"');
  int pos = start + 1;
  
  while (pos < input.length) {
    final char = input[pos];
    buffer.write(char);
    
    if (char == '\\') {
      pos++;
      if (pos < input.length) {
        buffer.write(input[pos]);
      }
    } else if (char == '"') {
      return ParseResult(buffer.toString(), pos + 1);
    }
    pos++;
  }
  
  throw FormatException('Unterminated string', input, start);
}

ParseResult _parseYamlSingleQuotedString(String input, int start) {
  final buffer = StringBuffer();
  buffer.write("'");
  int pos = start + 1;
  
  while (pos < input.length) {
    final char = input[pos];
    buffer.write(char);
    
    if (char == "'") {
      // Check for escaped single quote ('')
      if (pos + 1 < input.length && input[pos + 1] == "'") {
        buffer.write("'");
        pos += 2;
        continue;
      }
      return ParseResult(buffer.toString(), pos + 1);
    }
    pos++;
  }
  
  throw FormatException('Unterminated string', input, start);
}

ParseResult _parseYamlPlainString(String input, int start) {
  final buffer = StringBuffer();
  int pos = start;
  
  // Plain string ends at newline, colon, comma, bracket, or brace (in flow context)
  while (pos < input.length) {
    final char = input[pos];
    if (char == '\n' || char == '\r' || char == ':' || char == ',' || 
        char == '[' || char == ']' || char == '{' || char == '}' || char == '#') {
      break;
    }
    buffer.write(char);
    pos++;
  }
  
  // Trim trailing whitespace from plain strings
  final value = buffer.toString().trimRight();
  final actualEnd = start + value.length;
  
  return ParseResult(value, actualEnd);
}

ParseResult _parseYamlBlockScalar(String input, int start) {
  // Parse the block scalar header (|, |+, |-, |2, etc.)
  final buffer = StringBuffer();
  buffer.write(input[start]); // | or >
  int pos = start + 1;
  
  // Parse chomping indicator and/or indentation indicator
  while (pos < input.length && input[pos] != '\n' && input[pos] != '\r') {
    buffer.write(input[pos]);
    pos++;
  }
  
  // Skip newline after header
  if (pos < input.length && input[pos] == '\r') pos++;
  if (pos < input.length && input[pos] == '\n') pos++;
  buffer.write('\n');
  
  // Parse the block content (indented lines)
  int? baseIndent;
  
  while (pos < input.length) {
    // Check line indentation
    final lineStart = pos;
    int indent = 0;
    while (pos < input.length && (input[pos] == ' ' || input[pos] == '\t')) {
      indent++;
      pos++;
    }
    
    // Empty line or end of block scalar
    if (pos >= input.length || input[pos] == '\n' || input[pos] == '\r') {
      buffer.write(input.substring(lineStart, pos + 1));
      pos++;
      continue;
    }
    
    // Set base indentation from first non-empty line
    if (baseIndent == null) {
      baseIndent = indent;
    }
    
    // If indentation decreased, we've reached the end of the block
    if (indent < baseIndent) {
      break;
    }
    
    // Read rest of line
    while (pos < input.length && input[pos] != '\n' && input[pos] != '\r') {
      buffer.write(input[pos]);
      pos++;
    }
    
    if (pos < input.length && (input[pos] == '\n' || input[pos] == '\r')) {
      buffer.write(input[pos]);
      pos++;
    }
  }
  
  return ParseResult(buffer.toString(), pos);
}

/// Extracts field strings from a YAML mapping.
/// Returns a map of field names to their string representations.
Map<String, String> extractYamlMappingFields(String yaml) {
  yaml = yaml.trim();
  
  // Flow style mapping
  if (yaml.startsWith('{') && yaml.endsWith('}')) {
    return _extractYamlFlowMappingFields(yaml);
  }
  
  // Block style mapping
  return _extractYamlBlockMappingFields(yaml);
}

Map<String, String> _extractYamlFlowMappingFields(String yaml) {
  final result = <String, String>{};
  int pos = 1; // Skip opening brace
  
  while (pos < yaml.length - 1) {
    pos = skipWhitespace(yaml, pos);
    
    if (pos >= yaml.length - 1) break;
    if (yaml[pos] == '}') break;
    if (yaml[pos] == ',') {
      pos++;
      continue;
    }
    
    // Parse key (usually a plain string in flow style)
    final keyStart = pos;
    while (pos < yaml.length && yaml[pos] != ':' && yaml[pos] != ',') {
      pos++;
    }
    final key = yaml.substring(keyStart, pos).trim();
    
    // Expect colon
    if (pos >= yaml.length || yaml[pos] != ':') {
      throw FormatException('Expected colon after key', yaml, pos);
    }
    pos = skipWhitespace(yaml, pos + 1);
    
    // Parse value
    final valueStart = pos;
    int depth = 0;
    while (pos < yaml.length) {
      final char = yaml[pos];
      if (char == '{' || char == '[') {
        depth++;
      } else if (char == '}' || char == ']') {
        if (depth == 0) break;
        depth--;
      } else if (char == ',' && depth == 0) {
        break;
      }
      pos++;
    }
    
    result[key] = yaml.substring(valueStart, pos).trim();
  }
  
  return result;
}

Map<String, String> _extractYamlBlockMappingFields(String yaml) {
  final result = <String, String>{};
  final lines = yaml.split('\n');
  
  int i = 0;
  while (i < lines.length) {
    final line = lines[i];
    final trimmed = line.trim();
    
    if (trimmed.isEmpty || trimmed.startsWith('#')) {
      i++;
      continue;
    }
    
    // Find the key
    final colonIndex = line.indexOf(':');
    if (colonIndex == -1) {
      i++;
      continue;
    }
    
    final key = line.substring(0, colonIndex).trim();
    final valuePart = line.substring(colonIndex + 1).trim();
    
    // Inline value
    if (valuePart.isNotEmpty) {
      result[key] = valuePart;
      i++;
    } else {
      // Multi-line value (indented)
      final keyIndent = line.indexOf(key.isNotEmpty ? key[0] : ' ');
      final valueLines = <String>[];
      i++;
      
      while (i < lines.length) {
        final nextLine = lines[i];
        if (nextLine.trim().isEmpty) {
          valueLines.add(nextLine);
          i++;
          continue;
        }
        
        final nextIndent = nextLine.length - nextLine.trimLeft().length;
        if (nextIndent <= keyIndent) {
          break;
        }
        
        valueLines.add(nextLine);
        i++;
      }
      
      result[key] = valueLines.join('\n').trim();
    }
  }
  
  return result;
}

/// Extracts element strings from a YAML sequence.
/// Returns a list of element string representations.
List<String> extractYamlSequenceElements(String yaml) {
  yaml = yaml.trim();
  
  // Flow style sequence
  if (yaml.startsWith('[') && yaml.endsWith(']')) {
    return _extractYamlFlowSequenceElements(yaml);
  }
  
  // Block style sequence
  return _extractYamlBlockSequenceElements(yaml);
}

List<String> _extractYamlFlowSequenceElements(String yaml) {
  final result = <String>[];
  int pos = 1; // Skip opening bracket
  
  while (pos < yaml.length - 1) {
    pos = skipWhitespace(yaml, pos);
    
    if (pos >= yaml.length - 1) break;
    if (yaml[pos] == ']') break;
    if (yaml[pos] == ',') {
      pos++;
      continue;
    }
    
    // Parse element
    final elementStart = pos;
    int depth = 0;
    while (pos < yaml.length) {
      final char = yaml[pos];
      if (char == '{' || char == '[') {
        depth++;
      } else if (char == '}' || char == ']') {
        if (depth == 0) break;
        depth--;
      } else if (char == ',' && depth == 0) {
        break;
      }
      pos++;
    }
    
    result.add(yaml.substring(elementStart, pos).trim());
  }
  
  return result;
}

List<String> _extractYamlBlockSequenceElements(String yaml) {
  final result = <String>[];
  final lines = yaml.split('\n');
  
  int i = 0;
  while (i < lines.length) {
    final line = lines[i];
    final trimmed = line.trim();
    
    if (trimmed.isEmpty || trimmed.startsWith('#')) {
      i++;
      continue;
    }
    
    // Check for list item marker
    if (!trimmed.startsWith('-')) {
      i++;
      continue;
    }
    
    final itemIndent = line.indexOf('-');
    final valuePart = trimmed.substring(1).trim();
    
    // Inline value
    if (valuePart.isNotEmpty) {
      result.add(valuePart);
      i++;
    } else {
      // Multi-line value (indented)
      final valueLines = <String>[];
      i++;
      
      while (i < lines.length) {
        final nextLine = lines[i];
        if (nextLine.trim().isEmpty) {
          valueLines.add(nextLine);
          i++;
          continue;
        }
        
        final nextIndent = nextLine.length - nextLine.trimLeft().length;
        if (nextIndent <= itemIndent || nextLine.trim().startsWith('-')) {
          break;
        }
        
        valueLines.add(nextLine);
        i++;
      }
      
      result.add(valueLines.join('\n').trim());
    }
  }
  
  return result;
}

