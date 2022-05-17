from typing import Generic, TypeVar

A = TypeVar('A')

class Node(Generic[A]):
    def __init__(self, contents: A, left: 'Node[A]', right: 'Node[A]'):
        self.contents = contents
        self.left = left
        self.right = right
