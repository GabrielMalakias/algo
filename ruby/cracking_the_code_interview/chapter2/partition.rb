require 'minitest/autorun'
require_relative 'linked_list'

# Write code to partition a linked list around a value x such that all nodes less then x come before all nodes greater than or equal to z
#
# Example:
#
# 3 -> 5 -> 8 -> 5 -> 10 -> 2 -> 1 (partition = 5)
#
# 3 -> 2 -> 1   10 -> 5 -> 5 -> 8 (partition = 5)

class Solution
  def call(list, item)
    left_partition = LinkedList.new

    node = list.root
    previous = nil
    until node.nil?
      if node.value >= item
        left_partition.push(node.value)

        if previous.nil?
          list.root = node.next_node
        else
          previous.next_node = node.next_node
        end
      else
        previous = node
      end

      node = node.next_node
    end

    [list, left_partition]
  end
end

class CheckPartition < Minitest::Test
  def setup
    @solution = Solution.new
  end

  def test_when_the_value_exists
    list = LinkedList.new.push(3).push(5).push(8).push(5).push(10).push(2).push(1)

    first_partition, second_partition = @solution.call(list, 5)

    assert_equal [3, 2, 1], first_partition.to_a
    assert_equal [10, 5, 8, 5], second_partition.to_a
  end

  def test_when_the_split_is_in_the_end
    list = LinkedList.new.push(3).push(5).push(8).push(5).push(10).push(2).push(1)

    first_partition, second_partition = @solution.call(list, 3)

    assert_equal [2, 1], first_partition.to_a
    assert_equal [10, 5, 8, 5, 3], second_partition.to_a
  end

  def test_when_the_split_is_in_the_beginning
    list = LinkedList.new.push(3).push(5).push(8).push(5).push(10).push(2).push(11)

    first_partition, second_partition = @solution.call(list, 11)

    assert_equal [11], second_partition.to_a
    assert_equal [3, 5, 8, 5, 10, 2], first_partition.to_a
  end

  def test_when_list_is_empty
    list = LinkedList.new

    first_partition, second_partition = @solution.call(list, 5)

    assert_equal [], first_partition.to_a
    assert_equal [], second_partition.to_a
  end
end
