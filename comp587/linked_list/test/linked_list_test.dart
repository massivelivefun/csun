import 'package:linked_list/linked_list.dart';
import 'package:linked_list/no_such_element_exception.dart';
import 'package:test/test.dart';

void main() {
  
  group('addFront()', () {
    test('Empty list', () {
      var list = LinkedList();
      expect(list.toList(),
        orderedEquals([]));
    });

    test('Add one to list', () {
      var list = LinkedList();
      list.addFront(1);
      expect(list.toList(),
        orderedEquals([1]));
    });

    test('Add two to list', () {
      var list = LinkedList();
      list.addFront(2);
      list.addFront(1);
      expect(list.toList(),
        orderedEquals([1, 2]));
    });

    test('Add three to list', () {
      var list = LinkedList();
      list.addFront(3);
      list.addFront(2);
      list.addFront(1);
      expect(list.toList(),
        orderedEquals([1, 2, 3]));
    });
  });

  group('addBack()', () {
    test('Empty list', () {
      var list = LinkedList();
      expect(list.toList(),
        orderedEquals([]));
    });

    test('Add one to list', () {
      var list = LinkedList();
      list.addBack(1);
      expect(list.toList(),
        orderedEquals([1]));
    });

    test('Add two to list', () {
      var actual = LinkedList();
      actual.addBack(1);
      actual.addBack(2);
      expect(actual.toList(),
        orderedEquals([1, 2]));
    });

    test('Add three to list', () {
      var actual = LinkedList();
      actual.addBack(1);
      actual.addBack(2);
      actual.addBack(3);
      expect(actual.toList(),
        orderedEquals([1, 2, 3]));
    });
  });

  group('getElementAt()', () {
    test('Empty list && index @ -1', () {
      var list = LinkedList();
      expect(() => list.getElementAt(-1),
        throwsA(predicate((e) => e is NoSuchElementException &&
          e.message == 'Negative indices are not permitted.')));
    });

    test('Empty list && index @ 0', () {
      var list = LinkedList();
      expect(() => list.getElementAt(0),
        throwsA(predicate((e) => e is NoSuchElementException &&
          e.message == 'No element at index 0.')));
    });

    test('List of one && index @ 0', () {
      var list = LinkedList();
      list.addFront(1);
      expect(list.getElementAt(0),
        equals(1));
    });

    test('List of two && index @ 1', () {
      var list = LinkedList();
      list.addFront(2);
      list.addFront(1);
      expect(list.getElementAt(1),
        equals(2));
    });

    test('List of two && index @ 2', () {
      var list = LinkedList();
      list.addFront(3);
      list.addFront(2);
      list.addFront(1);
      expect(list.getElementAt(2),
        equals(3));
    });
  });

  group('getLength()', () {
    test('List with length of 0', () {
      var list = LinkedList();
      expect(list.getLength(), equals(0));
    });

    test('List with length of 1', () {
      var list = LinkedList();
      list.addFront(1);
      expect(list.getLength(), equals(1));
    });

    test('List with length of 2', () {
      var list = LinkedList();
      list.addFront(1);
      list.addFront(2);
      expect(list.getLength(), equals(2));
    });

    test('List with length of 3', () {
      var list = LinkedList();
      list.addFront(1);
      list.addFront(2);
      list.addFront(3);
      expect(list.getLength(), equals(3));
    });
  });

  group('toList()', () {
    test('Convert empty list', () {
      var list = LinkedList();
      expect(list.toList(),
        orderedEquals([]));
    });

    test('Convert list of one', () {
      var list = LinkedList();
      list.addFront(1);
      expect(list.toList(),
        orderedEquals([1]));
    });

    test('Convert list of two', () {
      var list = LinkedList();
      list.addFront(1);
      list.addFront(2);
      expect(list.toList(),
        orderedEquals([2, 1]));
    });

    test('Convert list of three', () {
      var list = LinkedList();
      list.addFront(1);
      list.addFront(2);
      list.addFront(3);
      expect(list.toList(),
        orderedEquals([3, 2, 1]));
    });
  });

  group('reverseList()', () {
    test('List with length of 0', () {
      var list = LinkedList();
      list.reverseList();
      expect(list.toList(),
        orderedEquals([]));
    });

    test('List with length of 1', () {
      var list = LinkedList();
      list.addFront(1);
      list.reverseList();
      expect(list.toList(),
        orderedEquals([1]));
    });

    test('List with length of 2', () {
      var list = LinkedList();
      list.addFront(2);
      list.addFront(1);
      list.reverseList();
      expect(list.toList(),
        orderedEquals([2, 1]));
    });

    test('List with length of 3', () {
      var list = LinkedList();
      list.addFront(3);
      list.addFront(2);
      list.addFront(1);
      list.reverseList();
      expect(list.toList(),
        orderedEquals([3, 2, 1]));
    });
  });
}
