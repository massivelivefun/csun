from pathlib import Path

relative_path_to_project_root = \
    Path(__file__).resolve().parent.parent

import sys
sys.path.append(str(relative_path_to_project_root))

from src.trees.node import Node
from src.trees.tree_operations import TreeOperations

# from trees import Node, TreeOperations

if __name__ == "__main__":
    #                    root
    #            left            right
    #    left2
    left2 = Node("left2", None, None)
    left = Node("left", left2, None)
    right = Node("right", None, None)
    tree = Node("root", left, right)

    print("\nBreath-First Search:")
    print(str(TreeOperations.bfs(tree)))

    print("\nPre-Order Traversal (Topological DFS):")
    # prints contents of nodes with left side bias
    print(str(TreeOperations.pre_order(tree)))

    print("\nMax Depth:")
    print(str(TreeOperations.max_depth(tree))) # prints 3
