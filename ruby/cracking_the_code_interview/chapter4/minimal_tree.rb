require 'minitest/autorun'

# Given a sorted (increasing order) array with unique integer elements, write an algorithm to create a binary search tree with minimal height
# [3, 4, 5, 6] with even number of items
#      4
#   /     \
# 3         6
#          /
#         5
#
#
# [2, 3, 4, 5, 6] with odd number of items
#      4
#   /     \
#  2       5
#  \        \
#   3        6
#
# Approach find the middle of the array or an approximation (for even numbers) and build the tree with that

class Node
  attr_accessor :value, :left, :right, :depth

  def initialize(value, depth)
    @value = value
    @depth = depth
  end

  def add_left(node)
    @left = node
  end

  def add_right(node)
    @right = node
  end
end

class BinaryTree
  attr_accessor :root

  def initialize
    @root = nil
  end

  def add(value)
    @root = insert_at(@root, value)
  end

  def insert_at(node, value, depth = 0)
    return Node.new(value, depth) if node.nil?

    if node.value > value
      node.left = insert_at(node.left, value, depth + 1)
    else
      node.right = insert_at(node.right, value, depth + 1)
    end

    node
  end

  def find(value)
    return nil if @root.nil?

    find_at(@root, value)
  end

  def find_at(node, value)
    return nil if node.nil?

    if node.value == value
      return node
    end

    if node.value > value
      return find_at(node.left, value)
    else
      return find_at(node.right, value)
    end
  end
end

class MinimalTree
  attr_accessor :tree

  def initialize
    @tree = BinaryTree.new
  end

  def build(array)
    return nil if array.empty?

    value = array.delete_at(middle_index(array))

    @tree.add(value)

    array.each do |item|
      @tree.add(item)
    end

    self
  end

  def find(value)
    @tree.find(value)
  end

  private

  def middle_index(array)
    (array.length / 2.to_f).ceil - 1
  end
end

class MinimalTreeTest < Minitest::Test
  def setup
    @tree = MinimalTree.new
  end

  def test_when_even_the_numbers_are_all_in_the_correct_level
    @tree.build([3, 4, 5, 6])

    assert_equal @tree.find(4).depth, 0
    assert_equal @tree.find(3).depth, 1
    assert_equal @tree.find(5).depth, 1
    assert_equal @tree.find(6).depth, 2
  end

  def test_when_odd_the_numbers_are_all_in_the_correct_level
    @tree.build([2, 3, 4, 5, 6])

    assert_equal @tree.find(4).depth, 0
    assert_equal @tree.find(3).depth, 2
    assert_equal @tree.find(2).depth, 1
    assert_equal @tree.find(5).depth, 1
    assert_equal @tree.find(6).depth, 2
  end
end
