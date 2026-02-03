// yaml_lossless.dart
//
// A *lossless* YAML document model that round-trips to the exact same string.
// Goal: parse YAML into compact pieces (especially whitespace/newlines), preserve
// comments, indentation, and provide line/column -> block mapping.
//
// This is NOT a full YAML 1.2 semantic parser. It’s a lossless *layout* parser:
// - It tokenizes into “pieces” that preserve exact text.
// - It builds an indentation-based block tree (good for editor mapping).
// - It can re-emit the original YAML byte-for-byte (for the covered cases).
//
// You can extend it later with richer node types (flow collections, anchors, tags,
// quoted scalars, etc.) while keeping the same lossless pieces underneath.

import 'dart:math';

import 'package:collection/collection.dart';

/// ----------------------------
/// Public API
/// ----------------------------

final class YamlDoc {
  final List<YamlPiece> pieces; // lossless physical representation
  final List<int> lineStartOffsets; // offset (in UTF-16 code units) of each line start
  final List<YamlLine> lines;
  final YamlBlock root;

  YamlDoc._({required this.pieces, required this.lineStartOffsets, required this.lines, required this.root});

  /// Parse a YAML string into a lossless document.
  static YamlDoc parse(String input) {
    final lexer = _YamlLosslessLexer(input);
    final pieces = lexer.lex();

    // Build line offsets from pieces (no need to keep input around).
    final lineStarts = <int>[0];
    int offset = 0;
    for (final p in pieces) {
      if (p is YamlNewline) {
        offset += p.length;
        lineStarts.add(offset);
      } else {
        offset += p.length;
      }
    }

    // Split pieces into lines.
    final lines = <YamlLine>[];
    int currentLineIndex = 0;
    int currentLineStartOffset = 0;
    final current = <YamlPiece>[];
    offset = 0;

    void flushLine({required bool endedByNewline}) {
      final linePieces = List<YamlPiece>.unmodifiable(current);
      current.clear();

      final line = YamlLine._(
        index: currentLineIndex,
        startOffset: currentLineStartOffset,
        pieces: linePieces,
        endedByNewline: endedByNewline,
      );
      lines.add(line);

      currentLineIndex++;
      currentLineStartOffset = offset; // current offset is start of next line
    }

    for (final p in pieces) {
      current.add(p);
      offset += p.length;
      if (p is YamlNewline) {
        flushLine(endedByNewline: true);
      }
    }
    // Last line (even if empty) if input doesn't end with newline, we still have a line.
    if (current.isNotEmpty || pieces.isEmpty || (pieces.isNotEmpty && pieces.last is! YamlNewline)) {
      flushLine(endedByNewline: false);
    }

    // Build indentation-based block tree from lines.
    final root = _YamlBlockBuilder.build(lines);

    return YamlDoc._(
      pieces: List<YamlPiece>.unmodifiable(pieces),
      lineStartOffsets: List<int>.unmodifiable(lineStarts),
      lines: List<YamlLine>.unmodifiable(lines),
      root: root,
    );
  }

  /// Reconstruct the YAML exactly (lossless round-trip).
  String toYaml() {
    final sb = StringBuffer();
    for (final p in pieces) {
      sb.write(p.toText());
    }
    return sb.toString();
  }

  /// Convert (line, column) to offset in UTF-16 code units.
  /// Line and column are 0-based.
  int offsetOf(int line, int column) {
    if (line < 0) throw RangeError.range(line, 0, max(0, lineStartOffsets.length - 1));
    if (line >= lineStartOffsets.length) throw RangeError.range(line, 0, max(0, lineStartOffsets.length - 1));

    final start = lineStartOffsets[line];
    return start + max(0, column);
  }

  /// Return the line that contains the given offset.
  int lineOfOffset(int offset) {
    // binary search greatest lineStartOffsets[i] <= offset
    int lo = 0, hi = lineStartOffsets.length - 1;
    while (lo <= hi) {
      final mid = (lo + hi) >> 1;
      final v = lineStartOffsets[mid];
      if (v == offset) return mid;
      if (v < offset) {
        lo = mid + 1;
      } else {
        hi = mid - 1;
      }
    }
    return max(0, lo - 1);
  }

  /// Return the smallest (deepest) block that contains [line].
  YamlBlock blockAtLine(int line) => root.deepestBlockContainingLine(line);

  /// Return the smallest (deepest) block that contains (line, column).
  /// (Column is currently only used to pick the line; you can refine later.)
  YamlBlock blockAtPosition(int line, int column) => blockAtLine(line);

  /// Return the piece at an absolute [offset] (UTF-16 code units).
  YamlPiece? pieceAtOffset(int offset) {
    if (offset < 0) return null;

    // Build prefix lengths on demand for binary search.
    // For big docs, you’d cache this in the doc.
    final ends = <int>[];
    int cur = 0;
    for (final p in pieces) {
      cur += p.length;
      ends.add(cur);
    }
    if (ends.isEmpty || offset >= ends.last) return null;

    int lo = 0, hi = ends.length - 1;
    while (lo < hi) {
      final mid = (lo + hi) >> 1;
      if (offset < ends[mid]) {
        hi = mid;
      } else {
        lo = mid + 1;
      }
    }
    return pieces[lo];
  }

  /// Debug helper: show blocks with ranges.
  String debugBlockTree() => root.pretty();
}

/// ----------------------------
/// Lines and Blocks
/// ----------------------------

final class YamlLine {
  final int index;
  final int startOffset; // UTF-16 code unit offset in document
  final List<YamlPiece> pieces;
  final bool endedByNewline;

  YamlLine._({required this.index, required this.startOffset, required this.pieces, required this.endedByNewline});

  /// Total length of this line (including trailing newline if present).
  int get length => pieces.fold(0, (a, b) => a + b.length);

  /// Text of line (including newline if present).
  String toText() {
    final sb = StringBuffer();
    for (final p in pieces) sb.write(p.toText());
    return sb.toString();
  }

  /// Count leading indentation (spaces only + tabs as 1 column here; you can change policy).
  int get indentColumns {
    int cols = 0;
    for (final p in pieces) {
      if (p is YamlWhitespace) {
        cols += p.columns;
      } else {
        break;
      }
    }
    return cols;
  }

  /// Whether the (non-whitespace) line begins with a `- ` sequence indicator.
  bool get isSequenceItem {
    final it = _nonWhitespaceIterator().iterator;
    final first = it.moveNext() ? it.current : null;
    if (first is YamlIndicator && first.text == '-') {
      final second = it.moveNext() ? it.current : null;
      return second is YamlWhitespace; // "- " (or "-\t") -> sequence item
    }
    return false;
  }

  /// Whether line looks like a mapping entry (contains ':' indicator outside quotes).
  /// This is heuristic, but good enough for block boundaries.
  bool get isMappingEntry {
    bool inSingle = false;
    bool inDouble = false;
    bool escaped = false;

    for (final p in pieces) {
      final s = p.toText();
      for (int i = 0; i < s.length; i++) {
        final ch = s[i];

        if (inDouble && !escaped && ch == '\\') {
          escaped = true;
          continue;
        }
        if (escaped) {
          escaped = false;
          continue;
        }

        if (!inDouble && ch == '\'') {
          inSingle = !inSingle;
          continue;
        }
        if (!inSingle && ch == '"') {
          inDouble = !inDouble;
          continue;
        }
        if (!inSingle && !inDouble && ch == ':') {
          return true;
        }
      }
    }
    return false;
  }

  bool get isBlankOrCommentOnly {
    bool sawNonWs = false;
    for (final p in pieces) {
      if (p is YamlNewline) break;
      if (p is YamlWhitespace) continue;
      if (p is YamlComment) return !sawNonWs;
      // any non-ws before comment -> not comment-only
      sawNonWs = true;
    }
    return !sawNonWs;
  }

  Iterable<YamlPiece> _nonWhitespaceIterator() sync* {
    for (final p in pieces) {
      if (p is YamlNewline) break;
      if (p is YamlWhitespace) continue;
      // If comment appears, we stop: YAML comments end the line.
      if (p is YamlComment) break;
      yield p;
    }
  }
}

enum YamlBlockKind { document, mapping, sequence, scalarOrUnknown }

/// Indentation-based physical block.
/// This is about layout, not semantic YAML node correctness.
final class YamlBlock {
  final YamlBlockKind kind;
  final int indent; // columns
  final int startLine; // inclusive
  int endLine; // inclusive, updated during build
  final List<YamlBlock> children;

  YamlBlock({
    required this.kind,
    required this.indent,
    required this.startLine,
    required this.endLine,
    List<YamlBlock>? children,
  }) : children = children ?? [];

  bool containsLine(int line) => line >= startLine && line <= endLine;

  YamlBlock deepestBlockContainingLine(int line) {
    for (final child in children) {
      if (child.containsLine(line)) {
        return child.deepestBlockContainingLine(line);
      }
    }
    return this;
  }

  String pretty([int depth = 0]) {
    final pad = '  ' * depth;
    final sb = StringBuffer();
    sb.writeln('$pad- $kind indent=$indent lines=$startLine..$endLine children=${children.length}');
    for (final c in children) {
      sb.write(c.pretty(depth + 1));
    }
    return sb.toString();
  }
}

/// ----------------------------
/// Pieces (lossless)
/// ----------------------------

sealed class YamlPiece {
  int get length; // UTF-16 code units
  String toText();
}

final class YamlWhitespace extends YamlPiece {
  // Compact: store kind + count.
  final int count;
  final bool isTab; // if false => spaces
  YamlWhitespace.spaces(this.count) : isTab = false;
  YamlWhitespace.tabs(this.count) : isTab = true;

  int get columns => count; // policy: 1 tab = 1 column (changeable)

  @override
  int get length => count;

  @override
  String toText() => isTab ? '\t' * count : ' ' * count;
}

final class YamlNewline extends YamlPiece {
  final bool isCrlf; // \r\n vs \n
  YamlNewline.lf() : isCrlf = false;
  YamlNewline.crlf() : isCrlf = true;

  @override
  int get length => isCrlf ? 2 : 1;

  @override
  String toText() => isCrlf ? '\r\n' : '\n';
}

final class YamlComment extends YamlPiece {
  // Stores the raw comment text starting from '#', up to (not including) newline.
  final String raw;
  YamlComment(this.raw);

  @override
  int get length => raw.length;

  @override
  String toText() => raw;
}

final class YamlIndicator extends YamlPiece {
  final String text; // single char typically
  YamlIndicator(this.text);

  @override
  int get length => text.length;

  @override
  String toText() => text;
}

final class YamlText extends YamlPiece {
  // Any non-special run we keep verbatim.
  final String text;
  YamlText(this.text);

  @override
  int get length => text.length;

  @override
  String toText() => text;
}

/// ----------------------------
/// Lexer (lossless tokenization)
/// ----------------------------

final class _YamlLosslessLexer {
  final String input;
  int i = 0;

  _YamlLosslessLexer(this.input);

  List<YamlPiece> lex() {
    final out = <YamlPiece>[];

    bool inSingle = false;
    bool inDouble = false;
    bool escaped = false;
    bool startOfLine = true;

    while (i < input.length) {
      final ch = input[i];

      // Newlines
      if (ch == '\n') {
        out.add(YamlNewline.lf());
        i += 1;
        startOfLine = true;
        inSingle = false; // YAML single quotes don't span lines in plain mode; heuristic reset
        inDouble = false;
        escaped = false;
        continue;
      }
      if (ch == '\r') {
        if (i + 1 < input.length && input[i + 1] == '\n') {
          out.add(YamlNewline.crlf());
          i += 2;
        } else {
          // rare bare CR; preserve as text
          out.add(YamlText('\r'));
          i += 1;
        }
        startOfLine = true;
        inSingle = false;
        inDouble = false;
        escaped = false;
        continue;
      }

      // Whitespace runs (spaces / tabs). Only treat as YAML whitespace when not inside quotes.
      if ((ch == ' ' || ch == '\t') && !inSingle && !inDouble) {
        final isTab = ch == '\t';
        int start = i;
        while (i < input.length && input[i] == (isTab ? '\t' : ' ')) {
          i++;
        }
        final count = i - start;
        out.add(isTab ? YamlWhitespace.tabs(count) : YamlWhitespace.spaces(count));
        // startOfLine remains true if we’re still in leading indentation
        continue;
      }

      // Quote state updates (so we can decide about comment starts + mapping heuristics later).
      // We'll still emit them as text/indicators as encountered.
      void updateQuoteState(String c) {
        if (inDouble && !escaped && c == r'\') {
          escaped = true;
          return;
        }
        if (escaped) {
          escaped = false;
          return;
        }
        if (!inDouble && c == "'") {
          inSingle = !inSingle;
        } else if (!inSingle && c == '"') {
          inDouble = !inDouble;
        }
      }

      // Comments (heuristic):
      // Treat '#' as comment start iff we're not inside quotes AND it is:
      // - start-of-line, or
      // - preceded by whitespace.
      if (ch == '#' && !inSingle && !inDouble) {
        final precededByWhitespace = (i == 0)
            ? true
            : (input[i - 1] == ' ' || input[i - 1] == '\t' || input[i - 1] == '\n' || input[i - 1] == '\r');
        if (startOfLine || precededByWhitespace) {
          final start = i;
          while (i < input.length && input[i] != '\n' && input[i] != '\r') {
            i++;
          }
          out.add(YamlComment(input.substring(start, i)));
          startOfLine = false;
          continue;
        }
      }

      // Indicators (keep as separate pieces; helps editor/block logic).
      // We include common YAML indicators, but keep it minimal and safe.
      const indicators = <String>{':', '-', '?', ',', '[', ']', '{', '}', '&', '*', '!', '|', '>', '%', '@'};
      if (indicators.contains(ch)) {
        updateQuoteState(ch);
        out.add(YamlIndicator(ch));
        i++;
        startOfLine = false;
        continue;
      }

      // Otherwise: consume a run of "text" until we hit a boundary.
      final start = i;
      while (i < input.length) {
        final c = input[i];
        if (c == '\n' || c == '\r') break;
        // Outside quotes, space/tab ends the run. Inside quotes it's part of the value.
        if (!inSingle && !inDouble && (c == ' ' || c == '\t')) break;
        if (!inSingle && !inDouble) {
          if (c == '#') {
            // Potential comment boundary (we stop so the outer loop can capture it).
            break;
          }
          // If indicator, stop to emit separately.
          if (indicators.contains(c)) break;
        }
        // Update quote state even inside the run.
        updateQuoteState(c);
        i++;
        startOfLine = false;
      }
      final text = input.substring(start, i);
      if (text.isNotEmpty) out.add(YamlText(text));
      startOfLine = false;
    }

    return out;
  }
}

/// ----------------------------
/// Block builder (indent-based)
/// ----------------------------

final class _YamlBlockBuilder {
  static YamlBlock build(List<YamlLine> lines) {
    final root = YamlBlock(kind: YamlBlockKind.document, indent: -1, startLine: 0, endLine: max(0, lines.length - 1));

    // Stack of open blocks. Always contains root.
    final stack = <YamlBlock>[root];

    for (int li = 0; li < lines.length; li++) {
      final line = lines[li];

      // Skip blank/comment-only lines from changing block structure,
      // but still extend current block's endLine.
      if (line.isBlankOrCommentOnly) {
        for (final b in stack) {
          b.endLine = max(b.endLine, li);
        }
        continue;
      }

      final indent = line.indentColumns;

      // Close blocks until we find a parent indent < current indent.
      while (stack.length > 1 && indent <= stack.last.indent) {
        stack.last.endLine = max(stack.last.endLine, li - 1);
        stack.removeLast();
      }

      // Determine block kind heuristically based on current line.
      final kind = line.isSequenceItem
          ? YamlBlockKind.sequence
          : (line.isMappingEntry ? YamlBlockKind.mapping : YamlBlockKind.scalarOrUnknown);

      // If the current top block already matches kind+indent, just extend it.
      // Otherwise, create a new child block at this indentation.
      final top = stack.last;
      final canReuse = top.kind == kind && top.indent == indent && top.children.isEmpty;

      if (!canReuse) {
        final b = YamlBlock(kind: kind, indent: indent, startLine: li, endLine: li);
        top.children.add(b);
        stack.add(b);
      } else {
        top.endLine = max(top.endLine, li);
      }

      // Extend all open blocks to at least this line.
      for (final b in stack) {
        b.endLine = max(b.endLine, li);
      }
    }

    // Close any remaining blocks.
    for (final b in stack) {
      b.endLine = max(b.endLine, lines.length - 1);
    }

    return root;
  }
}

/// ----------------------------
/// Quick usage example (remove in your project):
/// ----------------------------

void main() {
  final yaml = '''
# top comment
a: 1  # inline
b:
  - x
  - "y: not a mapping" # comment
c: |
  literal block
  preserves newlines

''';

  final doc = YamlDoc.parse(yaml);
  // final roundtrip = doc.toYaml();

  // print('Roundtrip identical: ${roundtrip == yaml}');
  // print('Block at line 3: ${doc.blockAtLine(3).kind}');
  // print(doc.debugBlockTree());
  doc.pieces.forEachIndexed((index, element) {
    print('$index: [${element.toString()}] [${(element is YamlNewline) ? r'\n' : element.toText()}]');
  });
}
