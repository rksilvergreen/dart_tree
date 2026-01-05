import 'package:dart_tree/dart_tree.dart';
import 'package:test/test.dart';

void main() {
  group('JSON Parsing', () {
    test('Can parse simple JSON string', () {
      final json = '"hello"';
      final tree = TreeIO.fromJson(json);

      expect(tree.root, isA<StringNode>());
      expect((tree.root as StringNode).value, equals('hello'));
    });

    test('Can parse JSON number', () {
      final tree1 = TreeIO.fromJson('42');
      expect((tree1.root as IntNode).value, equals(42));

      final tree2 = TreeIO.fromJson('3.14');
      expect((tree2.root as DoubleNode).value, equals(3.14));
    });

    test('Can parse JSON boolean', () {
      final tree1 = TreeIO.fromJson('true');
      expect((tree1.root as BoolNode).value, isTrue);

      final tree2 = TreeIO.fromJson('false');
      expect((tree2.root as BoolNode).value, isFalse);
    });

    test('Can parse JSON null', () {
      final tree = TreeIO.fromJson('null');
      expect(tree.root, isA<NullNode>());
    });

    test('Can parse JSON object', () {
      final json = '{"name": "Alice", "age": 30}';
      final tree = TreeIO.fromJson(json);

      expect(tree.root, isA<ObjectNode>());
      expect(tree.getString('/name'), equals('Alice'));
      expect(tree.getInt('/age'), equals(30));
    });

    test('Can parse JSON array', () {
      final json = '[1, 2, 3]';
      final tree = TreeIO.fromJson(json);

      expect(tree.root, isA<ArrayNode>());
      expect(tree.getInt('/0'), equals(1));
      expect(tree.getInt('/1'), equals(2));
      expect(tree.getInt('/2'), equals(3));
    });

    test('Can parse nested JSON structures', () {
      final json = '''
      {
        "users": [
          {"name": "Alice", "age": 30},
          {"name": "Bob", "age": 25}
        ]
      }
      ''';
      final tree = TreeIO.fromJson(json);

      expect(tree.getString('/users/0/name'), equals('Alice'));
      expect(tree.getInt('/users/0/age'), equals(30));
      expect(tree.getString('/users/1/name'), equals('Bob'));
      expect(tree.getInt('/users/1/age'), equals(25));
    });

    test('Parsed JSON preserves source positions when requested', () {
      final json = '{"key": "value"}';
      final tree = TreeIO.fromJson(json, preserveSyntax: true);

      final root = tree.root!;
      expect(root.sourceRange, isNotNull);
      expect(root.sourceRange!.start.line, greaterThan(0));
    });
  });

  group('JSON Serialization', () {
    test('Can serialize string node', () {
      final tree = Tree(root: StringNode('hello'));
      final json = tree.toJson(prettyPrint: false);
      expect(json, equals('"hello"'));
    });

    test('Can serialize number nodes', () {
      final tree1 = Tree(root: IntNode(42));
      expect(tree1.toJson(prettyPrint: false), equals('42'));

      final tree2 = Tree(root: DoubleNode(3.14));
      expect(tree2.toJson(prettyPrint: false), equals('3.14'));
    });

    test('Can serialize boolean nodes', () {
      final tree1 = Tree(root: BoolNode(true));
      expect(tree1.toJson(prettyPrint: false), equals('true'));

      final tree2 = Tree(root: BoolNode(false));
      expect(tree2.toJson(prettyPrint: false), equals('false'));
    });

    test('Can serialize null node', () {
      final tree = Tree(root: NullNode());
      expect(tree.toJson(prettyPrint: false), equals('null'));
    });

    test('Can serialize object node', () {
      final root = ObjectNode();
      final tree = Tree(root: root);
      tree.setChild(parent: root, key: 'name', child: StringNode('Alice'));
      tree.setChild(parent: root, key: 'age', child: IntNode(30));

      final json = tree.toJson(prettyPrint: false);
      expect(json, contains('"name"'));
      expect(json, contains('"Alice"'));
      expect(json, contains('"age"'));
      expect(json, contains('30'));
    });

    test('Can serialize array node', () {
      final root = ArrayNode();
      final tree = Tree(root: root);
      tree.setChild(parent: root, key: '0', child: IntNode(1));
      tree.setChild(parent: root, key: '1', child: IntNode(2));
      tree.setChild(parent: root, key: '2', child: IntNode(3));

      final json = tree.toJson(prettyPrint: false);
      expect(json, equals('[1,2,3]'));
    });

    test('Pretty printing adds indentation', () {
      final root = ObjectNode();
      final tree = Tree(root: root);
      tree.setChild(parent: root, key: 'key', child: StringNode('value'));

      final json = tree.toJson(prettyPrint: true);
      expect(json, contains('\n'));
      expect(json, contains('  '));
    });
  });

  group('JSON Roundtrip', () {
    test('Simple values roundtrip correctly', () {
      final inputs = [
        '"hello"',
        '42',
        '3.14',
        'true',
        'false',
        'null',
      ];

      for (final input in inputs) {
        final tree = TreeIO.fromJson(input);
        final output = tree.toJson(prettyPrint: false);
        expect(output, equals(input));
      }
    });

    test('Objects roundtrip correctly', () {
      final input = '{"name":"Alice","age":30}';
      final tree = TreeIO.fromJson(input);
      final output = tree.toJson(prettyPrint: false);

      // Parse both to compare semantically (order might differ)
      final inputTree = TreeIO.fromJson(input);
      final outputTree = TreeIO.fromJson(output);

      expect(outputTree.getString('/name'), equals(inputTree.getString('/name')));
      expect(outputTree.getInt('/age'), equals(inputTree.getInt('/age')));
    });

    test('Arrays roundtrip correctly', () {
      final input = '[1,2,3]';
      final tree = TreeIO.fromJson(input);
      final output = tree.toJson(prettyPrint: false);
      expect(output, equals(input));
    });

    test('Complex nested structures roundtrip correctly', () {
      final inputJson = '''
      {
        "users": [
          {"name": "Alice", "age": 30, "active": true},
          {"name": "Bob", "age": 25, "active": false}
        ],
        "total": 2
      }
      ''';

      final tree = TreeIO.fromJson(inputJson);
      final outputJson = tree.toJson(prettyPrint: false);

      final outputTree = TreeIO.fromJson(outputJson);

      expect(outputTree.getString('/users/0/name'), equals('Alice'));
      expect(outputTree.getInt('/users/0/age'), equals(30));
      expect(outputTree.getBool('/users/0/active'), isTrue);
      expect(outputTree.getInt('/total'), equals(2));
    });
  });

  group('JSON with Syntax Preservation', () {
    test('Preserves number format when requested', () {
      final json = '{"value": 1.0}';
      final tree = TreeIO.fromJson(json, preserveSyntax: true);

      final valueNode = tree.query('/value') as DoubleNode;
      expect(valueNode.formatting?.numberFormat, equals('1.0'));

      final output = tree.toJson(preserveFormatting: true, prettyPrint: false);
      expect(output, contains('1.0'));
    });
  });
}

