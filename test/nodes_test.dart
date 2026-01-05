import 'package:dart_tree/dart_tree.dart';
import 'package:test/test.dart';

void main() {
  group('Value Nodes', () {
    test('StringNode stores and retrieves string values', () {
      final node = StringNode('hello');
      expect(node.value, equals('hello'));
      expect(node.id, isNotEmpty);
    });

    test('IntNode stores and retrieves integer values', () {
      final node = IntNode(42);
      expect(node.value, equals(42));
    });

    test('DoubleNode stores and retrieves double values', () {
      final node = DoubleNode(3.14);
      expect(node.value, equals(3.14));
    });

    test('BoolNode stores and retrieves boolean values', () {
      final trueNode = BoolNode(true);
      final falseNode = BoolNode(false);
      expect(trueNode.value, isTrue);
      expect(falseNode.value, isFalse);
    });

    test('NullNode represents null values', () {
      final node = NullNode();
      expect(node.value, isNull);
    });
  });

  group('Node Cloning', () {
    test('Cloned nodes have different IDs but same values', () {
      final original = StringNode('test');
      final cloned = original.clone();

      expect(cloned.id, isNot(equals(original.id)));
      expect(cloned.value, equals(original.value));
    });

    test('Cloned nodes preserve formatting info', () {
      final original = StringNode(
        'test',
        formatting: FormattingInfo(quoteStyle: QuoteStyle.single),
      );
      final cloned = original.clone();

      expect(cloned.formatting?.quoteStyle, equals(QuoteStyle.single));
    });
  });

  group('Source Position', () {
    test('Nodes can store source position information', () {
      final position = SourcePosition(line: 5, column: 10, offset: 50);
      final range = SourceRange(
        start: position,
        end: SourcePosition(line: 5, column: 15, offset: 55),
      );

      final node = StringNode('test', sourceRange: range);
      expect(node.sourceRange?.start.line, equals(5));
      expect(node.sourceRange?.start.column, equals(10));
      expect(node.sourceRange?.end.column, equals(15));
    });
  });

  group('Union Nodes', () {
    test('UnionNode2 can hold first type', () {
      final stringNode = StringNode('hello');
      final union = UnionNode2<StringNode, IntNode>.first(stringNode);

      expect(union.isFirst, isTrue);
      expect(union.isSecond, isFalse);
      expect(union.asFirst?.value, equals('hello'));
      expect(union.asSecond, isNull);
    });

    test('UnionNode2 can hold second type', () {
      final intNode = IntNode(42);
      final union = UnionNode2<StringNode, IntNode>.second(intNode);

      expect(union.isFirst, isFalse);
      expect(union.isSecond, isTrue);
      expect(union.asSecond?.value, equals(42));
      expect(union.asFirst, isNull);
    });

    test('UnionNode2 supports pattern matching', () {
      final union1 = UnionNode2<StringNode, IntNode>.first(StringNode('test'));
      final union2 = UnionNode2<StringNode, IntNode>.second(IntNode(42));

      final result1 = union1.when(
        first: (node) => 'String: ${node.value}',
        second: (node) => 'Int: ${node.value}',
      );

      final result2 = union2.when(
        first: (node) => 'String: ${node.value}',
        second: (node) => 'Int: ${node.value}',
      );

      expect(result1, equals('String: test'));
      expect(result2, equals('Int: 42'));
    });

    test('UnionNode3 can hold all three types', () {
      final union1 = UnionNode3<StringNode, IntNode, BoolNode>.first(StringNode('a'));
      final union2 = UnionNode3<StringNode, IntNode, BoolNode>.second(IntNode(1));
      final union3 = UnionNode3<StringNode, IntNode, BoolNode>.third(BoolNode(true));

      expect(union1.isFirst, isTrue);
      expect(union2.isSecond, isTrue);
      expect(union3.isThird, isTrue);
    });
  });

  group('Collection Nodes', () {
    test('ObjectNode can be created', () {
      final node = ObjectNode();
      expect(node.id, isNotEmpty);
    });

    test('ArrayNode can be created', () {
      final node = ArrayNode();
      expect(node.id, isNotEmpty);
    });
  });
}

