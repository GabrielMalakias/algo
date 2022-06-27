require 'minitest/autorun'

# Design an algorithm and write code to find the first common ancestor of two nodes in a binary tree. Avoid storing additional nodes in the structure. NOTE: This is not necessarily a binary search tree
#
#        1
#      /   \
#    3       8
#  /  \     /  \
# 4   9    7   2
#
# When 8, 3 => 1
#      4, 9 => 3
#      4, 8 => 1
#
#
class Node
  attr_accessor :value, :left, :right

  def initialize(value)
    @value = value
  end
end

class Tree
  attr_accessor :root

  def insert(value)
    @root = insert_at(@root, value)
  end

  def insert_at(node, value)
    return Node.new(value) if node.nil?

    if node.value <= value
      node.left = insert_at(node.left, value)
    else
      node.right = insert_at(node.right, value)
    end

    node
  end

  def first_common_ancestor(node_a, node_b)
    stack_a = find(node_a)
    stack_b = find(node_b)

    stack_a.reverse.each do |item|
      return item if stack_b.include? item
    end

    nil
  end

  def find(value)
    stack = []

    find_with_stack(root, value, stack)

    stack
  end

  def find_with_stack(node, value, stack)
    return false if node.nil?
    return true if node.value == value

    stack.push(node.value)

    return stack if find_with_stack(node.left, value, stack)
    return stack if find_with_stack(node.right, value, stack)

    false
  end
end

class FindAncestorTest < Minitest::Test
  def setup
    @tree = Tree.new
  end

  def test_find_with_stack
    @tree.insert(1)
    @tree.insert(3)
    @tree.insert(8)
    @tree.insert(4)
    @tree.insert(9)
    @tree.insert(7)
    @tree.insert(2)

    assert_equal @tree.find(8), [1, 3]
  end

  def test_when_the_common_ancestor_is_in_the_top
    @tree.insert(1)
    @tree.insert(3)
    @tree.insert(8)
    @tree.insert(4)
    @tree.insert(9)
    @tree.insert(7)
    @tree.insert(2)

    assert_equal @tree.first_common_ancestor(8, 3), 1
  end

  def test_when_the_common_ancestor_is_in_the_middle
    @tree.insert(1)
    @tree.insert(3)
    @tree.insert(8)
    @tree.insert(4)
    @tree.insert(9)
    @tree.insert(7)
    @tree.insert(2)

    assert_equal @tree.first_common_ancestor(4, 9), 8
  end

  def test_when_the_tree_is_empty
    assert_nil @tree.first_common_ancestor(4, 9)
  end

  def when_the_item_does_not_exists_on_the_tree
    assert_nil @tree.first_common_ancestor(4, 9)
  end
end
