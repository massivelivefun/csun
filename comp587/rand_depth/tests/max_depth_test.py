from src.rand_depth.node import Node
from src.rand_depth.tree_operations import TreeOperations
import types
from typing import TypeVar
import unittest


TreeOpClassInst = TreeOperations()


def test_max_depth_3_bunch_of_times():
    num_of_trees = 9999
    max_depth = 3
    for _ in range(0, num_of_trees):
        root = TreeOperations.gen_tree(max_depth)
        assert TreeOperations.max_depth(root) == max_depth


def test_max_depth_4_bunch_of_times():
    num_of_trees = 9999
    max_depth = 4
    for _ in range(0, num_of_trees):
        root = TreeOperations.gen_tree(max_depth)
        assert TreeOperations.max_depth(root) == max_depth


def test_max_depth_5_bunch_of_times():
    num_of_trees = 9999
    max_depth = 5
    for _ in range(0, num_of_trees):
        root = TreeOperations.gen_tree(max_depth)
        assert TreeOperations.max_depth(root) == max_depth
        
        
def test_gen_tree_is_static_method():
    assert isinstance(TreeOpClassInst.gen_tree, types.FunctionType)


def test_max_depth_is_static_method():
    assert isinstance(TreeOpClassInst.max_depth, types.FunctionType)


# def test_a_is_typedef_object():
#     assert isinstance(A, TypeVar)
    