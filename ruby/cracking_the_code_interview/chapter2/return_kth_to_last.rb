require 'minitest/autorun'

# Implement an algorithm to find the kth to last algorithm of a singly linked list
# O(N) + O(K..N) -> To build the array
#
#
class Node
  attr_accessor :next_node, :value

  def initialize(value, next_node)
    @value = value
    @next_node = next_node
  end
end

class LinkedList
  attr_accessor :root

  def push(value)
    node = Node.new(value, root)
    @root = node

    self
  end

  def to_a
    node = @root
    array = []

    until node.nil?
      array << node.value

      node = node.next_node
    end

    array
  end

  def empty?
    @root.nil?
  end
end

class Solution
  def call(list, kth)
    return [] if list.empty?

    node = list.root
    index = 0

    until node.nil?
      if index == kth
        list.root = node
        break
      end

      node = node.next_node
      index += 1
    end

    list
  end
end

class ReturnKthToLast < Minitest::Test
  def setup
    @solution = Solution.new
  end

  def test_the_correct_values_when_list_is_not_empty
    list = LinkedList.new.push(3).push(4).push(3)

    assert_equal [4, 3], @solution.call(list, 1).to_a
  end

  def test_empty_when_list_is_empty
    list = LinkedList.new

    assert_equal [], @solution.call(list, 3).to_a
  end
end
