import 'package:linked_list/linked_list.dart';

void main() {
  var list = LinkedList();

  list.addFront(2);
  list.addFront(1);
  list.addBack(3);
  list.addBack(4);

  // root -> 1, node -> 2, node -> 3, node -> 4, node -> null

  var index = 0;
  var len = list.getLength();

  while (index < len) {
    print('getElementAt($index): ${list.getElementAt(index)}');
    index++;
  }

  var array = list.toList();
  list.reverseList();
  var reverse = list.toList();

  print('$array');
  print('$reverse');
}
