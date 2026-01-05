/// Utilities for working with JSON Pointer (RFC 6901) paths.
class Pointer {
  /// Builds a JSON Pointer from a list of path segments.
  /// 
  /// Examples:
  /// - `[]` → `/`
  /// - `['users', '0', 'name']` → `/users/0/name`
  static String build(List<String> segments) {
    if (segments.isEmpty) {
      return '/';
    }

    // Filter out empty segments but keep '/'
    final filtered = segments.where((s) => s.isNotEmpty || s == '/').toList();
    if (filtered.isEmpty) {
      return '/';
    }

    // If first segment is empty or '/', start with '/'
    if (filtered.first.isEmpty || filtered.first == '/') {
      if (filtered.length == 1) {
        return '/';
      }
      return '/${filtered.skip(1).map(_escapeSegment).join('/')}';
    }

    return '/${filtered.map(_escapeSegment).join('/')}';
  }

  /// Parses a JSON Pointer into its segments.
  /// 
  /// Examples:
  /// - `/` → `[]`
  /// - `/users/0/name` → `['users', '0', 'name']`
  static List<String> parse(String pointer) {
    if (pointer == '/') {
      return [];
    }

    if (!pointer.startsWith('/')) {
      throw FormatException('JSON Pointer must start with /: $pointer');
    }

    return pointer
        .substring(1) // Remove leading /
        .split('/')
        .map(_unescapeSegment)
        .toList();
  }

  /// Escapes a segment for use in a JSON Pointer.
  /// 
  /// Per RFC 6901:
  /// - `~` becomes `~0`
  /// - `/` becomes `~1`
  static String _escapeSegment(String segment) {
    return segment.replaceAll('~', '~0').replaceAll('/', '~1');
  }

  /// Unescapes a segment from a JSON Pointer.
  static String _unescapeSegment(String segment) {
    return segment.replaceAll('~1', '/').replaceAll('~0', '~');
  }

  /// Joins two pointers together.
  static String join(String base, String relative) {
    if (base == '/') {
      return relative;
    }
    if (relative == '/') {
      return base;
    }
    if (relative.startsWith('/')) {
      return '$base$relative';
    }
    return '$base/$relative';
  }

  /// Gets the parent pointer of the given pointer.
  /// 
  /// Examples:
  /// - `/users/0/name` → `/users/0`
  /// - `/users` → `/`
  /// - `/` → `null`
  static String? parent(String pointer) {
    if (pointer == '/') {
      return null;
    }

    final lastSlash = pointer.lastIndexOf('/');
    if (lastSlash == 0) {
      return '/';
    }

    return pointer.substring(0, lastSlash);
  }

  /// Gets the last segment of the pointer (the key or index).
  /// 
  /// Examples:
  /// - `/users/0/name` → `name`
  /// - `/users` → `users`
  /// - `/` → `null`
  static String? lastSegment(String pointer) {
    if (pointer == '/') {
      return null;
    }

    final segments = parse(pointer);
    return segments.isEmpty ? null : segments.last;
  }
}

