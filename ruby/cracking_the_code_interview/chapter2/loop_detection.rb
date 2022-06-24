require 'minitest/autorun'
require 'set'

# Given a linked list which might contain a loop, implement an algorithm that
# returns the node at the beginning of the loop (if one exists)
#
# A -> B -> C -> D -> E -> C
# C

class Node
  attr_accessor :value, :next_node

  def initialize(value)
    @value = value
  end
end

class LinkedList
  attr_accessor :root

  def initialize(array)
    previous = nil
    array.each do |value|
      node = Node.new(value)

      if previous.nil?
        @root = node
      else
        previous.next_node = node
      end

      previous = node
    end
  end

  def to_s
    node = self.root
    str = ""
    while node != nil
      str = str + "#{node.value} -> "
      node = node.next_node
    end

    str
  end

  def empty?
    root.nil?
  end
end

class Solution
  def call(list)
    return nil if list.empty?

    set = Set.new

    node = list.root
    while node != nil
      return node.value if set.include?(node.value)

      set.add(node.value)
      node = node.next_node
    end
  end
end

class LoopDetectionTest < Minitest::Test
  def setup
    @solution = Solution.new
  end

  def test_when_there_is_a_loop
    list = LinkedList.new(['A', 'B', 'C', 'D', 'E', 'C'])

    assert_equal 'C', @solution.call(list)
  end

  def test_when_there_isnt_a_loop
    list = LinkedList.new(['A', 'B', 'C', 'D', 'E'])

    assert_nil @solution.call(list)
  end

  def test_when_the_list_is_empty
    list = LinkedList.new([])

    assert_nil @solution.call(list)
  end
end
