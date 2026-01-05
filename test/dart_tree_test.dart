import 'package:dart_tree/dart_tree.dart';
import 'package:test/test.dart';

void main() {
  test('Library exports all necessary components', () {
    // Verify that the main exports are accessible
    expect(StringNode, isNotNull);
    expect(IntNode, isNotNull);
    expect(DoubleNode, isNotNull);
    expect(BoolNode, isNotNull);
    expect(NullNode, isNotNull);
    expect(ObjectNode, isNotNull);
    expect(ArrayNode, isNotNull);
    expect(Tree, isNotNull);
  });
}
