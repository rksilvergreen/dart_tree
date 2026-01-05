import 'package:dart_tree/dart_tree.dart';
import 'package:test/test.dart';

void main() {
  group('YAML Parsing', () {
    test('Can parse simple YAML string', () {
      final yaml = 'hello';
      final tree = TreeIO.fromYaml(yaml);

      expect(tree.root, isA<StringNode>());
      expect((tree.root as StringNode).value, equals('hello'));
    });

    test('Can parse YAML number', () {
      final tree1 = TreeIO.fromYaml('42');
      expect((tree1.root as IntNode).value, equals(42));

      final tree2 = TreeIO.fromYaml('3.14');
      expect((tree2.root as DoubleNode).value, equals(3.14));
    });

    test('Can parse YAML boolean', () {
      final tree1 = TreeIO.fromYaml('true');
      expect((tree1.root as BoolNode).value, isTrue);

      final tree2 = TreeIO.fromYaml('false');
      expect((tree2.root as BoolNode).value, isFalse);
    });

    test('Can parse YAML null', () {
      final tree = TreeIO.fromYaml('null');
      expect(tree.root, isA<NullNode>());
    });

    test('Can parse YAML object', () {
      final yaml = '''
name: Alice
age: 30
''';
      final tree = TreeIO.fromYaml(yaml);

      expect(tree.root, isA<ObjectNode>());
      expect(tree.getString('/name'), equals('Alice'));
      expect(tree.getInt('/age'), equals(30));
    });

    test('Can parse YAML array', () {
      final yaml = '''
- 1
- 2
- 3
''';
      final tree = TreeIO.fromYaml(yaml);

      expect(tree.root, isA<ArrayNode>());
      expect(tree.getInt('/0'), equals(1));
      expect(tree.getInt('/1'), equals(2));
      expect(tree.getInt('/2'), equals(3));
    });

    test('Can parse nested YAML structures', () {
      final yaml = '''
users:
  - name: Alice
    age: 30
  - name: Bob
    age: 25
''';
      final tree = TreeIO.fromYaml(yaml);

      expect(tree.getString('/users/0/name'), equals('Alice'));
      expect(tree.getInt('/users/0/age'), equals(30));
      expect(tree.getString('/users/1/name'), equals('Bob'));
      expect(tree.getInt('/users/1/age'), equals(25));
    });

    test('Can parse YAML flow style arrays', () {
      final yaml = 'numbers: [1, 2, 3]';
      final tree = TreeIO.fromYaml(yaml);

      expect(tree.query('/numbers'), isA<ArrayNode>());
      expect(tree.getInt('/numbers/0'), equals(1));
      expect(tree.getInt('/numbers/1'), equals(2));
      expect(tree.getInt('/numbers/2'), equals(3));
    });

    test('Can parse YAML flow style objects', () {
      final yaml = 'person: {name: Alice, age: 30}';
      final tree = TreeIO.fromYaml(yaml);

      expect(tree.getString('/person/name'), equals('Alice'));
      expect(tree.getInt('/person/age'), equals(30));
    });
  });

  group('YAML Serialization', () {
    test('Can serialize string node', () {
      final tree = Tree(root: StringNode('hello'));
      final yaml = tree.toYaml();
      expect(yaml, equals('hello'));
    });

    test('Can serialize number nodes', () {
      final tree1 = Tree(root: IntNode(42));
      expect(tree1.toYaml(), equals('42'));

      final tree2 = Tree(root: DoubleNode(3.14));
      expect(tree2.toYaml(), equals('3.14'));
    });

    test('Can serialize boolean nodes', () {
      final tree1 = Tree(root: BoolNode(true));
      expect(tree1.toYaml(), equals('true'));

      final tree2 = Tree(root: BoolNode(false));
      expect(tree2.toYaml(), equals('false'));
    });

    test('Can serialize null node', () {
      final tree = Tree(root: NullNode());
      expect(tree.toYaml(), equals('null'));
    });

    test('Can serialize object node', () {
      final root = ObjectNode();
      final tree = Tree(root: root);
      tree.setChild(parent: root, key: 'name', child: StringNode('Alice'));
      tree.setChild(parent: root, key: 'age', child: IntNode(30));

      final yaml = tree.toYaml();
      expect(yaml, contains('name: Alice'));
      expect(yaml, contains('age: 30'));
    });

    test('Can serialize array node', () {
      final root = ArrayNode();
      final tree = Tree(root: root);
      tree.setChild(parent: root, key: '0', child: IntNode(1));
      tree.setChild(parent: root, key: '1', child: IntNode(2));
      tree.setChild(parent: root, key: '2', child: IntNode(3));

      final yaml = tree.toYaml();
      expect(yaml, contains('- 1'));
      expect(yaml, contains('- 2'));
      expect(yaml, contains('- 3'));
    });

    test('Can serialize using flow style', () {
      final root = ArrayNode();
      final tree = Tree(root: root);
      tree.setChild(parent: root, key: '0', child: IntNode(1));
      tree.setChild(parent: root, key: '1', child: IntNode(2));

      final yaml = tree.toYaml(useFlowStyle: true);
      expect(yaml, equals('[1, 2]'));
    });
  });

  group('YAML Roundtrip', () {
    test('Simple values roundtrip correctly', () {
      final inputs = [
        'hello',
        '42',
        '3.14',
        'true',
        'false',
        'null',
      ];

      for (final input in inputs) {
        final tree = TreeIO.fromYaml(input);
        final output = tree.toYaml();
        
        // Parse output and compare values
        final outputTree = TreeIO.fromYaml(output);
        if (tree.root is StringNode) {
          expect((outputTree.root as StringNode).value, 
                 equals((tree.root as StringNode).value));
        } else if (tree.root is IntNode) {
          expect((outputTree.root as IntNode).value,
                 equals((tree.root as IntNode).value));
        }
      }
    });

    test('Objects roundtrip correctly', () {
      final input = '''
name: Alice
age: 30
''';
      final tree = TreeIO.fromYaml(input);
      final output = tree.toYaml();
      final outputTree = TreeIO.fromYaml(output);

      expect(outputTree.getString('/name'), equals('Alice'));
      expect(outputTree.getInt('/age'), equals(30));
    });

    test('Arrays roundtrip correctly', () {
      final input = '''
- 1
- 2
- 3
''';
      final tree = TreeIO.fromYaml(input);
      final output = tree.toYaml();
      final outputTree = TreeIO.fromYaml(output);

      expect(outputTree.getInt('/0'), equals(1));
      expect(outputTree.getInt('/1'), equals(2));
      expect(outputTree.getInt('/2'), equals(3));
    });
  });

  group('YAML Special Features', () {
    test('Strings requiring quotes are properly quoted', () {
      final root = ObjectNode();
      final tree = Tree(root: root);
      
      // These strings need quoting in YAML
      tree.setChild(parent: root, key: 'bool_like', child: StringNode('true'));
      tree.setChild(parent: root, key: 'number_like', child: StringNode('42'));
      tree.setChild(parent: root, key: 'with_colon', child: StringNode('key: value'));

      final yaml = tree.toYaml();
      
      // Re-parse and verify types are preserved
      final reparsed = TreeIO.fromYaml(yaml);
      expect(reparsed.getString('/bool_like'), equals('true'));
      expect(reparsed.getString('/number_like'), equals('42'));
      expect(reparsed.getString('/with_colon'), equals('key: value'));
    });
  });
}

