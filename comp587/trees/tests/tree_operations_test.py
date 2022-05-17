from src.trees.node import Node, A
from src.trees.tree_operations import TreeOperations
import types
from typing import TypeVar
import unittest

# I want to incorporate the unittest package
# class TreeOperationTest(unittest.TestCase):
#     pass

# left heavy tree
l_left2 = Node("left2", None, None)
l_left = Node("left", l_left2, None)
l_right = Node("right", None, None)
left_heavy_tree = Node("root", l_left, l_right)


# right heavy tree
r_right2 = Node("right2", None, None)
r_right = Node("right", r_right2, None)
r_left = Node("left", None, None)
right_heavy_tree = Node("root", r_left, r_right)


# single node tree
root_tree = Node("root", None, None)


# An instance of TreeOperations
TreeOpClassInst = TreeOperations()


def test_bfs_left_heavy():
    assert TreeOperations.bfs(left_heavy_tree) == \
        ['root', 'left', 'right', 'left2']


def test_bfs_right_heavy():
    assert TreeOperations.bfs(right_heavy_tree) == \
        ['root', 'left', 'right', 'right2']


def test_bfs_root():
    assert TreeOperations.bfs(root_tree) == ['root']
    

def test_bfs_none():
    assert TreeOperations.bfs(None) == []


def test_pre_order_left_heavy():
    assert TreeOperations.pre_order(left_heavy_tree) == \
        ['root', 'left', 'left2', 'right']


def test_pre_order_right_heavy():
    assert TreeOperations.pre_order(right_heavy_tree) == \
        ['root', 'left', 'right', 'right2']


def test_pre_order_root():
    assert TreeOperations.pre_order(root_tree) == ['root']
    
    
def test_pre_order_none():
    assert TreeOperations.pre_order(None) == []


def test_max_depth_left_heavy():
    assert TreeOperations.max_depth(left_heavy_tree) == 3


def test_max_depth_right_heavy():
    assert TreeOperations.max_depth(right_heavy_tree) == 3


def test_max_depth_root():
    assert TreeOperations.max_depth(root_tree) == 1
    
    
def test_max_depth_none():
    assert TreeOperations.max_depth(None) == 0


def test_bfs_is_static_method():
    assert isinstance(TreeOpClassInst.bfs, types.FunctionType)


def test_pre_order_is_static_method():
    assert isinstance(TreeOpClassInst.pre_order, types.FunctionType)


def test_max_depth_is_static_method():
    assert isinstance(TreeOpClassInst.max_depth, types.FunctionType)


def test_a_is_typedef_object():
    assert isinstance(A, TypeVar)


# def test_a_is_typedef_a_object():
#     assert A == TypeVar('A')
