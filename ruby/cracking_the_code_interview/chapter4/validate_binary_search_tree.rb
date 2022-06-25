require 'minitest/autorun'

# Implement a function to check if a BinaryTree is a BinarySearch tree
#
#
#
class Node
  attr_accessor :value, :right, :left

  def initialize(value)
    @value = value
  end
end

class BinaryTree
  attr_accessor :root

  def self.build(input)
    BinaryTree.new.tap do |t|
      input.each do |value|
        t.add(value)
      end
    end
  end

  def add(value)
    @root = insert_at(@root, value)
  end

  private

  def insert_at(node, value)
    return Node.new(value) if node.nil?

    if node.value < value
      node.left = insert_at(node.left, value)
    else
      node.right = insert_at(node.right, value)
    end

    node
  end
end

class BinarySearchTree
  attr_accessor :root

  def self.build(input)
    BinarySearchTree.new.tap do |t|
      input.each do |value|
        t.add(value)
      end
    end
  end

  def add(value)
    @root = insert_at(@root, value)
  end

  private

  def insert_at(node, value)
    return Node.new(value) if node.nil?

    if node.value > value
      node.left = insert_at(node.left, value)
    else
      node.right = insert_at(node.right, value)
    end

    node
  end
end

class ValidateBinarySearchTree
  def call(tree)
    check(tree.root)
  end

  def check(root)
    return true if root.nil?

    left_valid = root.left.nil? || root.value >= root.left.value
    right_valid = root.right.nil? || root.value < root.right.value

    return false if !left_valid || !right_valid

    lcheck = check(root.left) if !root.left.nil?
    rcheck = check(root.right) if !root.right.nil?

    (lcheck.nil? || lcheck) && (rcheck.nil? || rcheck)
  end
end

class ValidateBinarySearchTreeTest < Minitest::Test
  def setup
    @solution = ValidateBinarySearchTree.new
  end

  def test_when_its_a_binary_search_tree
    tree = BinarySearchTree.build([6, 8, 3, 7])

    assert_equal @solution.call(tree), true
  end

  def test_when_its_not_a_binary_search_tree
    tree = BinaryTree.build([6, 8, 3, 7])

    assert_equal @solution.call(tree), false
  end
end
