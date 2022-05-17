import 'no_such_element_exception.dart';

class _Node<T> {
  late T? _data;
  late _Node<T>? _next;

  _Node(final T? data, final _Node<T>? next) {
    _data = data;
    _next = next;
  }

  T? getData() {
    return _data;
  }

  void setData(final T data) {
    _data = data;
  }

  _Node<T>? getNext() {
    return _next;
  }

  void setNext(final _Node<T>? next) {
    _next = next;
  }
}

class LinkedList<T> {
  late _Node<T>? _head;
  late _Node<T>? _tail;
  int _length = 0;

  LinkedList() {
    _head = null;
    _tail = null;
    _length = 0;
  }

  void addFront(final T element) {
    if (_head == null && _tail == null) {
      _head = _Node(element, _head);
      _tail = _head;
    } else {
      _head = _Node(element, _head);
    }
    _length += 1;
  }

  void addBack(final T element) {
    if (_head == null && _tail == null) {
      _head = _Node(element, null);
      _tail = _head;
    } else {
      _tail!.setNext(_Node(element, null));
      _tail = _tail!.getNext();
    }
    _length += 1;
  }

  T getElementAt(final int index) {
    if (index < 0) {
      throw NoSuchElementException('Negative indices are not permitted.');
    }

    var curPos = 0;
    var current = _head;

    while (curPos < index && current != null) {
      current = current.getNext();
      curPos += 1;
    }

    if (current != null && current.getData() != null) {
      assert(curPos == index);
      return current.getData()!;
    } else {
      throw NoSuchElementException('No element at index $index.');
    }
  }

  int getLength() {
    return _length;
  }

  List<T?> toList() {
    var result = List<T?>.filled(getLength(), null);
    var current = _head;
    var index = 0;

    while (current != null && current.getData() != null) {
      result[index] = current.getData();
      current = current.getNext();
      index += 1;
    }
    return result;
  }

  void reverseList() {
    var current = _head;
    var next;
    var prev;

    while (current != null) {
      next = current.getNext();
      current.setNext(prev);
      prev = current;
      current = next;
    }
    _head = prev;
  }
}
