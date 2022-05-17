# linked_list

A simple singly linked list library for dart developers and their applications.

## Usage

A simple usage example (refer to example directory for the actual file):

```dart
import 'package:linked_list/linked_list.dart';

void main() {
  var list = LinkedList();

  list.addFront(2);
  list.addFront(1);
  list.addBack(3);
  list.addBack(4);

  var index = 0;
  var len = list.length();

  while (index < len) {
    print('getElementAt: ${list.getElementAt(index)}');
    index++;
  }

  var array = list.toList();
  list.reverseList();
  var reverse = list.toList();

  print('$array');
  print('$reverse');
}
```

To run tests use the following command in your terminal:
```
pub run test -r <compact|expanded|github|json>
```
Please see dart dev's [test package](https://pub.dev/packages/test) 
for more information.

## Features and bugs

Please file feature requests and bugs at the
[issue tracker](https://github.com/massivelivefun/linked_list/issues).

## Copyright and licenses

Created from templates made available by Stagehand under a BSD-style
[license](https://github.com/dart-lang/stagehand/blob/master/LICENSE).
