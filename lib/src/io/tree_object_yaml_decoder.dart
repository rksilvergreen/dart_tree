import 'package:yaml/yaml.dart';

/// Decodes YAML strings to TreeObject instances.
///
/// This is a simple wrapper that uses the `yaml` package's parser.
///
/// **Important:** This basic implementation does NOT extract formatting/style
/// metadata. For lossless round-tripping with full metadata preservation,
/// you need to implement a custom YAML parser that:
/// 1. Tracks source positions (line/column numbers)
/// 2. Captures string quote styles (single/double/plain/literal/folded)
/// 3. Preserves number formatting (hex/octal/binary/exponential)
/// 4. Records bool representations (true/false/yes/no/on/off)
/// 5. Records null representations (null/~/empty)
/// 6. Captures collection styles (flow vs block)
/// 7. Records indentation and whitespace
/// 8. Preserves comments and their positions
/// 9. Passes this metadata to the `fromYaml` methods via optional parameters
///
/// The static `fromYaml` methods on TreeObject classes accept optional
/// formatting parameters for this purpose.
class TreeObjectYamlDecoder {
  /// Decodes a YAML string to a dynamic value.
  ///
  /// This uses the standard `yaml` package which only extracts semantic values.
  /// For full metadata extraction, use a custom parser that passes formatting
  /// information to the TreeObject `fromYaml` methods.
  static dynamic decode(String yaml) {
    return loadYaml(yaml);
  }
}
