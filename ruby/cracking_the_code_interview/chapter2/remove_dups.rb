require 'minitest/autorun'

# Write code to remote duplicates from an unsorted linked list
# TimeComplexity O(N)
# SpaceComplexity O(N) + O(M) Where M is the number of unique values
#
# Solved using hash to map if the value is present

class Node
  attr_reader :value, :next_node

  def initialize(value, next_node = nil)
    @value = value
    @next_node = next_node
  end

  def set_next(node)
    @next_node = node
  end
end

class LinkedList
  attr_reader :root

  def push(value)
    @root = Node.new(value, root)

    self
  end

  def to_a
    array = []

    node = root
    until node.nil?
      array << node.value

      node = node.next_node
    end

    array
  end
end

class Solution
  def call(list)
    present = {}

    node = list.root
    previous = nil

    until node.nil?
      if present[node.value].nil?
        present[node.value] = true
        previous = node
      else
        previous.set_next(node.next_node)
      end

      node = node.next_node
    end

    list
  end
end

class RemoveDups < Minitest::Test
  def setup
    @solution = Solution.new
  end

  def test_that_duplicates_where_removed
    list = LinkedList.new.push(3).push(4).push(4).push(3).push(5)

    assert_equal [5, 3, 4], @solution.call(list).to_a
  end
end
