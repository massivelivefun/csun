from collections import deque
from .node import Node

class TreeOperations:
    @staticmethod
    def bfs(nd: Node) -> list:
        new_list = []
        queue = deque([])
        if nd:
            queue.append(nd)
            # while queue has element returns true
            while queue:
                v = queue.popleft()
                if v:
                    new_list.append(v.contents)
                    print(v.contents)
                    # if v.left is not None
                    if v.left:
                        queue.append(v.left)
                    # if v.right is not None
                    if v.right:
                        queue.append(v.right)
        return new_list


    @staticmethod
    def pre_order(nd: Node) -> list:
        new_list = []
        if nd:
            new_list.append(nd.contents)
            new_list += TreeOperations.pre_order(nd.left)
            new_list += TreeOperations.pre_order(nd.right)
        return new_list


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
