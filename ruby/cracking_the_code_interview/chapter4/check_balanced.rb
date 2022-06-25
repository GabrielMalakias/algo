require 'minitest/autorun'

# Implement a function to check if a binary tree is balanced. For the purposes of this question,
# a balanced tree is defined to be a tree such that the heights of the two subtrees of any node
# never differ by more than one
#
class Node
  attr_accessor :value, :left, :right, :depth

  def initialize(value, depth)
    @value = value
    @depth = depth
  end

  def bottom?
    @left.nil? && @right.nil?
  end
end

class Tree
  attr_accessor :root

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

  def height(node)
    return node.depth if node.bottom?

    left_height = height(node.left) if !node.left.nil?
    right_height = height(node.right) if !node.right.nil?

    left_height.to_i > right_height.to_i ? left_height : right_height
  end

  def empty?
    @root.nil?
  end

  def self.build(array)
    Tree.new.tap do |t|
      array.each do |item|
        t.add(item)
      end
    end
  end
end

class CheckBalanced
  def call(tree)
    return true if tree.empty?

    (tree.height(tree.root.left) - tree.height(tree.root.right)).abs <= 1
  end
end

class CheckBalancedTest < Minitest::Test
  def setup
    @solution = CheckBalanced.new
  end

  def test_when_the_tree_is_balanced
    input = [4, 3, 6, 5]
    tree = Tree.build(input)

    assert_equal @solution.call(tree), true
  end

  def test_when_the_tree_is_not_balanced
    input = [4, 3, 7, 10, 9]
    tree = Tree.build(input)

    assert_equal @solution.call(tree), false
  end

  def test_when_the_tree_is_empty
    input = []
    tree = Tree.build(input)

    assert_equal @solution.call(tree), true
  end
end
