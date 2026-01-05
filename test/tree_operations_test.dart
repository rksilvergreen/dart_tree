import 'package:dart_tree/dart_tree.dart';
import 'package:test/test.dart';

void main() {
  group('Tree Construction', () {
    test('Can create a tree with a simple root', () {
      final root = StringNode('root');
      final tree = Tree(root: root);

      expect(tree.root, equals(root));
      expect(tree.id, isNotEmpty);
    });

    test('Can create a tree with an object root and children', () {
      final root = ObjectNode();
      final tree = Tree(root: root);

      final nameNode = StringNode('Alice');
      final ageNode = IntNode(30);

      tree.setChild(parent: root, key: 'name', child: nameNode);
      tree.setChild(parent: root, key: 'age', child: ageNode);

      expect(tree.getChild(root, 'name'), equals(nameNode));
      expect(tree.getChild(root, 'age'), equals(ageNode));
    });

    test('Can create a tree with an array root and children', () {
      final root = ArrayNode();
      final tree = Tree(root: root);

      tree.setChild(parent: root, key: '0', child: IntNode(1));
      tree.setChild(parent: root, key: '1', child: IntNode(2));
      tree.setChild(parent: root, key: '2', child: IntNode(3));

      final children = tree.getChildren(root)!;
      expect(children.length, equals(3));
      expect((children['0'] as IntNode).value, equals(1));
      expect((children['1'] as IntNode).value, equals(2));
      expect((children['2'] as IntNode).value, equals(3));
    });
  });

  group('Tree Query Operations', () {
    late Tree tree;

    setUp(() {
      final root = ObjectNode();
      tree = Tree(root: root);

      final usersArray = ArrayNode();
      tree.setChild(parent: root, key: 'users', child: usersArray);

      final user1 = ObjectNode();
      tree.setChild(parent: usersArray, key: '0', child: user1);
      tree.setChild(parent: user1, key: 'name', child: StringNode('Alice'));
      tree.setChild(parent: user1, key: 'age', child: IntNode(30));

      final user2 = ObjectNode();
      tree.setChild(parent: usersArray, key: '1', child: user2);
      tree.setChild(parent: user2, key: 'name', child: StringNode('Bob'));
      tree.setChild(parent: user2, key: 'age', child: IntNode(25));
    });

    test('Can query nodes by path', () {
      final node = tree.query('/users/0/name');
      expect(node, isA<StringNode>());
      expect((node as StringNode).value, equals('Alice'));
    });

    test('Query returns null for non-existent paths', () {
      final node = tree.query('/users/5/name');
      expect(node, isNull);
    });

    test('Can get string values directly', () {
      final name = tree.getString('/users/0/name');
      expect(name, equals('Alice'));
    });

    test('Can get int values directly', () {
      final age = tree.getInt('/users/1/age');
      expect(age, equals(25));
    });

    test('Can check if paths exist', () {
      expect(tree.exists('/users'), isTrue);
      expect(tree.exists('/users/0'), isTrue);
      expect(tree.exists('/users/0/name'), isTrue);
      expect(tree.exists('/nonexistent'), isFalse);
    });

    test('Can get child nodes', () {
      final children = tree.getChildNodes('/users');
      expect(children?.length, equals(2));
    });

    test('Can get child paths', () {
      final paths = tree.getChildPaths('/users/0');
      expect(paths, contains('/users/0/name'));
      expect(paths, contains('/users/0/age'));
    });
  });

  group('Tree Traversal', () {
    late Tree tree;

    setUp(() {
      final root = ObjectNode();
      tree = Tree(root: root);

      tree.setChild(parent: root, key: 'a', child: StringNode('value_a'));
      
      final bObject = ObjectNode();
      tree.setChild(parent: root, key: 'b', child: bObject);
      tree.setChild(parent: bObject, key: 'b1', child: IntNode(1));
      tree.setChild(parent: bObject, key: 'b2', child: IntNode(2));
    });

    test('Pre-order traversal visits parent before children', () {
      final visited = <String>[];
      tree.traverse((node, depth, path) {
        visited.add('${node.runtimeType}@$path');
      }, order: TraversalOrder.preOrder);

      expect(visited[0], contains('ObjectNode@/'));
      expect(visited[1], contains('StringNode@/a'));
      expect(visited[2], contains('ObjectNode@/b'));
    });

    test('Post-order traversal visits children before parent', () {
      final visited = <String>[];
      tree.traverse((node, depth, path) {
        visited.add('${node.runtimeType}@$path');
      }, order: TraversalOrder.postOrder);

      // Children visited before parents
      expect(visited.last, contains('ObjectNode@/'));
    });

    test('Can find all nodes matching a predicate', () {
      final intNodes = tree.findAll((node) => node is IntNode);
      expect(intNodes.length, equals(2));
    });

    test('Can find first node matching a predicate', () {
      final firstInt = tree.findFirst((node) => node is IntNode);
      expect(firstInt, isA<IntNode>());
    });

    test('Traversal with control can skip children', () {
      final visited = <String>[];
      tree.traverseWithControl((node, depth, path) {
        visited.add(path);
        if (path == '/b') {
          return TraversalAction.skipChildren;
        }
        return TraversalAction.continue_;
      });

      expect(visited, contains('/b'));
      expect(visited, isNot(contains('/b/b1')));
      expect(visited, isNot(contains('/b/b2')));
    });

    test('Traversal with control can stop early', () {
      final visited = <String>[];
      tree.traverseWithControl((node, depth, path) {
        visited.add(path);
        if (visited.length >= 2) {
          return TraversalAction.stop;
        }
        return TraversalAction.continue_;
      });

      expect(visited.length, equals(2));
    });
  });

  group('Tree Mutation', () {
    test('Can update a node in place', () {
      final root = ObjectNode();
      final tree = Tree(root: root);
      tree.setChild(parent: root, key: 'value', child: StringNode('old'));

      tree.updateAt('/value', StringNode('new'));

      final updated = tree.getString('/value');
      expect(updated, equals('new'));
    });

    test('Can delete a node', () {
      final root = ObjectNode();
      final tree = Tree(root: root);
      tree.setChild(parent: root, key: 'toDelete', child: StringNode('bye'));

      expect(tree.exists('/toDelete'), isTrue);

      tree.deleteAt('/toDelete');

      expect(tree.exists('/toDelete'), isFalse);
    });

    test('Can set a node at a path', () {
      final root = ObjectNode();
      final tree = Tree(root: root);

      tree.setAt('/newKey', StringNode('newValue'));

      expect(tree.getString('/newKey'), equals('newValue'));
    });
  });

  group('Immutable Operations', () {
    test('replaceAt returns new tree without modifying original', () {
      final root = ObjectNode();
      final tree = Tree(root: root);
      tree.setChild(parent: root, key: 'value', child: StringNode('original'));

      final newTree = tree.replaceAt('/value', StringNode('modified'));

      expect(tree.getString('/value'), equals('original'));
      expect(newTree.getString('/value'), equals('modified'));
    });

    test('withoutAt returns new tree without the node', () {
      final root = ObjectNode();
      final tree = Tree(root: root);
      tree.setChild(parent: root, key: 'keep', child: StringNode('keep'));
      tree.setChild(parent: root, key: 'remove', child: StringNode('remove'));

      final newTree = tree.withoutAt('/remove');

      expect(tree.exists('/remove'), isTrue);
      expect(newTree.exists('/remove'), isFalse);
      expect(newTree.exists('/keep'), isTrue);
    });

    test('withAt returns new tree with node added', () {
      final root = ObjectNode();
      final tree = Tree(root: root);

      final newTree = tree.withAt('/newKey', StringNode('newValue'));

      expect(tree.exists('/newKey'), isFalse);
      expect(newTree.exists('/newKey'), isTrue);
      expect(newTree.getString('/newKey'), equals('newValue'));
    });
  });

  group('Subtree Operations', () {
    test('Can remove a subtree', () {
      final root = ObjectNode();
      final tree = Tree(root: root);

      final subObject = ObjectNode();
      tree.setChild(parent: root, key: 'sub', child: subObject);
      tree.setChild(parent: subObject, key: 'child', child: StringNode('value'));

      final subtree = tree.removeSubtree(subObject);

      expect(tree.exists('/sub'), isFalse);
      expect(subtree.exists('/child'), isTrue);
    });

    test('Can add a subtree', () {
      final root = ObjectNode();
      final tree = Tree(root: root);

      final subRoot = ObjectNode();
      final subtree = Tree(root: subRoot);
      subtree.setChild(parent: subRoot, key: 'child', child: StringNode('value'));

      tree.setChild(parent: root, key: 'sub', child: ObjectNode());
      tree.addSubtree(parent: root, key: 'sub', subtree: subtree);

      expect(tree.exists('/sub/child'), isTrue);
      expect(tree.getString('/sub/child'), equals('value'));
    });

    test('Can clone a tree', () {
      final root = ObjectNode();
      final tree = Tree(root: root);
      tree.setChild(parent: root, key: 'value', child: StringNode('test'));

      final cloned = tree.clone();

      expect(cloned.id, isNot(equals(tree.id)));
      expect(cloned.getString('/value'), equals('test'));

      // Modify clone doesn't affect original
      cloned.setAt('/value', StringNode('modified'));
      expect(tree.getString('/value'), equals('test'));
      expect(cloned.getString('/value'), equals('modified'));
    });
  });
}

