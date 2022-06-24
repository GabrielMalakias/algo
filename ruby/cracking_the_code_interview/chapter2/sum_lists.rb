require 'minitest/autorun'

# Sums two linked lists in reverse order where each item is an integer
#
# (7 -> 1 -> 6) + (5 + 9 + 2) => 617 + 295
# Approach: Go though the two lists reversing the string and converting it to an integer
#
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
  def call(first, second)
    sum_nodes(first) + sum_nodes(second)
  end

  def sum_nodes(list)
    return 0 if list.empty?

    str = ""
    node = list.root
    while node != nil
      str = "#{node.value}#{str}"
      node = node.next_node
    end

    str.to_i
  end
end

class SumLinkedLists < Minitest::Test
  def setup
    @solution = Solution.new
  end

  def test_when_the_list_contains_items
    first = LinkedList.new([7, 1, 6])
    second = LinkedList.new([5, 9, 2])

    assert_equal 912, @solution.call(first, second)
  end

  def test_when_the_first_list_does_not_contain_items
    first = LinkedList.new([])
    second = LinkedList.new([5, 9, 2])

    assert_equal 295, @solution.call(first, second)
  end

  def test_when_the_second_list_does_not_contain_items
    first = LinkedList.new([7, 1, 6])
    second = LinkedList.new([])

    assert_equal 617, @solution.call(first, second)
  end

  def test_when_the_both_lists_are_empty
    first = LinkedList.new([])
    second = LinkedList.new([])

    assert_equal 0, @solution.call(first, second)
  end
end
