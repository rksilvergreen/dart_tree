import 'dart:convert';

/// Decodes JSON strings to TreeObject instances.
///
/// This is a simple wrapper that uses Dart's built-in JSON parser.
///
/// **Important:** This basic implementation does NOT extract formatting/style
/// metadata. For lossless round-tripping with full metadata preservation,
/// you need to implement a custom JSON parser that:
/// 1. Tracks source positions (line/column numbers)
/// 2. Captures string quote styles and escape sequences
/// 3. Preserves number formatting (scientific notation, etc.)
/// 4. Records whitespace and indentation
/// 5. Passes this metadata to the `fromJson` methods via optional parameters
///
/// The static `fromJson` methods on TreeObject classes accept optional
/// formatting parameters for this purpose.
class TreeObjectJsonDecoder {
  /// Decodes a JSON string to a dynamic value.
  ///
  /// This uses Dart's standard `jsonDecode` which only extracts semantic values.
  /// For full metadata extraction, use a custom parser that passes formatting
  /// information to the TreeObject `fromJson` methods.
  static dynamic decode(String json) {
    return jsonDecode(json);
  }
}
