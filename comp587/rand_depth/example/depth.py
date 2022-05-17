from pathlib import Path

relative_path_to_project_root = \
    Path(__file__).resolve().parent.parent

import sys
sys.path.append(str(relative_path_to_project_root))

from src.rand_depth.node import Node
from src.rand_depth.tree_operations import TreeOperations

if __name__ == "__main__":
    root = TreeOperations.gen_tree(3)
    assert TreeOperations.max_depth(root) == 3
