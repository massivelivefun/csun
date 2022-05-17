from .node import Node
from collections import deque
import random


class TreeOperations:
    @staticmethod
    def gen_tree(max_depth: int) -> Node:
        root = Node(str(max_depth), None, None)
        if max_depth < 1:
            return None
        else:
            lower_bound = 0
            assert lower_bound == 0
            upper_bound = 2
            assert upper_bound == 2
            k = random.randint(lower_bound, upper_bound)
            new_max_depth = max_depth - 1
            assert new_max_depth == max_depth - 1
            if k == 0:
                assert k == 0
                root.left = TreeOperations.gen_tree(new_max_depth)
            elif k == 1:
                assert k == 1
                root.right = TreeOperations.gen_tree(new_max_depth)
            else:
                assert k == 2
                root.left = TreeOperations.gen_tree(new_max_depth)
                root.right = TreeOperations.gen_tree(new_max_depth)
        return root


    @staticmethod
    def max_depth(nd: Node) -> int:
        def max_depth_func(nd: Node, level: int) -> int:
            # if nd is not None
            if nd:
                return max(max_depth_func(nd.left, level + 1),
                    max_depth_func(nd.right, level + 1))
            # else return the level
            else:
                return level
        start = 0
        return max_depth_func(nd, start)
