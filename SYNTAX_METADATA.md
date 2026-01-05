# Syntactic Metadata for Lossless YAML/JSON Roundtripping

This document catalogs all syntactic information needed to perfectly preserve formatting when parsing and serializing YAML and JSON files.

## JSON Syntax Metadata

### 1. Strings
- Always double-quoted (JSON requirement)
- Escape sequences used (what was `\n` vs actual newline before escaping)
- Unicode escape format (`\uXXXX` vs literal character)

### 2. Numbers
- Integer vs decimal representation
- Scientific notation (`1e5` vs `100000`)
- Decimal places for floats (`1.0` vs `1.00`)
- Negative zero (`-0`)

### 3. Objects (Mappings)
- **Property order** (critical for preservation)
- Whitespace:
  - Before/after opening `{`
  - Around `:` (key-value separator)
  - Around `,` (between properties)
  - Before closing `}`
- Indentation level and style (spaces/tabs)
- Line breaks (single-line vs multi-line)
- Trailing comma (if parser allows, technically invalid)

### 4. Arrays (Sequences)
- Whitespace:
  - Before/after opening `[`
  - Around `,` (between items)
  - Before closing `]`
- Indentation
- Line breaks (single-line vs multi-line)
- Trailing comma (if parser allows)

### 5. Booleans & Null
- Fixed format: `true`, `false`, `null`
- Just need source position

### 6. General
- Indentation style (spaces vs tabs, count)
- Line ending style (`\n` vs `\r\n`)
- Top-level formatting
- Comments (if using JSON5/JSONC with comment support)

---

## YAML Syntax Metadata

YAML is significantly more complex than JSON with many syntactic variations.

### 1. Strings (Scalars)

Multiple representation styles:

#### A. Quoted Strings

**Double-quoted** (`"hello"`)
- Escape sequences: `\n`, `\t`, `\"`, `\\`, `\uXXXX`, etc.

**Single-quoted** (`'hello'`)
- Only escape: `''` for literal single quote

#### B. Unquoted (Plain) Strings
- No quotes: `hello world`
- Need to preserve exact spacing/format

#### C. Literal Block Scalar (`|`)
```yaml
text: |
  Line 1
  Line 2
```
- Block chomping indicator: `|`, `|-` (strip), `|+` (keep)
- Indentation indicator: `|2` (explicit indent)
- Indentation level

#### D. Folded Block Scalar (`>`)
```yaml
text: >
  This will be
  folded into
  one line
```
- Same indicators as literal: `>`, `>-`, `>+`
- Indentation handling

### 2. Numbers

Multiple formats:
- **Decimal**: `123`, `123.45`
- **Octal**: `0o177`
- **Hexadecimal**: `0xFF`
- **Binary**: `0b1010`
- **Exponential**: `1.23e+5`
- **Special floats**: `.inf`, `-.inf`, `.nan`
- Underscores for readability: `1_000_000`

### 3. Booleans

Multiple representations (case variations):
- **True**: `true`, `True`, `TRUE`, `yes`, `Yes`, `YES`, `on`, `On`, `ON`
- **False**: `false`, `False`, `FALSE`, `no`, `No`, `NO`, `off`, `Off`, `OFF`

### 4. Null

Multiple representations:
- `null`, `Null`, `NULL`
- `~` (tilde)
- Empty value (just key with no value)

### 5. Mappings (Objects)

Two main styles:

#### A. Block Style
```yaml
key1: value1
key2: value2
nested:
  child1: val1
  child2: val2
```
- Indentation level (typically 2 or 4 spaces)
- Space after colon (required: `: `)
- Order of keys

#### B. Flow Style
```yaml
person: {name: Alice, age: 30}
```
- Braces `{}`
- Whitespace around braces, colons, commas
- Can mix: block mapping with flow values

#### Metadata Needed
- Style choice (block vs flow)
- Indentation (spaces count)
- Key order
- Whitespace patterns
- Complex keys (when key itself is a mapping/sequence)

### 6. Sequences (Arrays)

Two main styles:

#### A. Block Style
```yaml
- item1
- item2
- nested:
  - sub1
  - sub2
```
- Dash position and indentation
- Indentation of items

#### B. Flow Style
```yaml
items: [1, 2, 3]
```
- Brackets `[]`
- Whitespace patterns

#### Metadata Needed
- Style choice
- Indentation
- Dash position (inline vs separate line)

### 7. Anchors & Aliases
```yaml
defaults: &defaults
  color: blue
  
item1:
  <<: *defaults
  name: Item1
```
- Anchor name (`&defaults`)
- Alias reference (`*defaults`)
- Merge keys (`<<:`)

### 8. Tags (Explicit Typing)
```yaml
timestamp: !!timestamp 2025-01-04
custom: !mytype value
```
- Tag name (`!!timestamp`, `!mytype`)
- Position (before value)

### 9. Documents
```yaml
---
document: 1
...
---
document: 2
```
- Document start marker (`---`)
- Document end marker (`...`)
- Multiple documents in stream

### 10. Comments
```yaml
# Full line comment
key: value  # Inline comment
```
- Position (line/inline)
- Content and spacing
- Multiple lines

### 11. General Formatting
- Indentation style (must be spaces, no tabs)
- Indentation count (2, 4, etc.)
- Line endings (`\n` vs `\r\n`)
- Blank lines between elements
- Trailing whitespace
- Source positions for everything

### 12. Edge Cases
- Empty collections: `[]`, `{}`
- Multiline keys
- Question mark for explicit keys: `? key : value`
- Multiple documents
- Mixed styles (block inside flow, flow inside block)

---

## Summary

### JSON Requirements
- Simpler: mainly whitespace, indentation, and number formats
- Property/array order critical
- Escape sequences for strings

### YAML Requirements
- Highly complex with many syntactic choices
- Multiple representations for same semantic value
- Block vs flow styles for collections
- Rich string formatting options
- Anchors/aliases for references
- Comments throughout
- Tags for explicit typing

Both formats require precise source position tracking to enable error reporting and selective updates.

