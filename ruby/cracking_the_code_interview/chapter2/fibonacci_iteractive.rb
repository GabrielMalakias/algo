require 'minitest/autorun'

# Implement fibonacci using stack
#
#
class Node
  attr_accessor :value, :next_node

  def initialize(value)
    @value = value
  end
end

class Stack # = LIFO (Last In - First Out) with LinkedList
  attr_accessor :top

  def push(value)
    node = Node.new(value)
    node.next_node = @top
    @top = node
    value
  end

  def peek
    return nil if empty?

    @top.value
  end

  def pop
    return nil if empty?

    value = @top.value
    @top = @top.next_node
    value
  end

  def empty?
    @top.nil?
  end
end

class Solution
  def initialize
    @stack = Stack.new
  end

  def call(n)
    # return n if n < 2

    # call(n - 1) + call(n - 2)
    sum = 0
    @stack.push(n)
    while !@stack.empty?
      value = @stack.pop
      if value == 0 || value == 1
        sum = sum + 1
      else
        @stack.push(value - 1)
        @stack.push(value - 2)
      end
    end
    sum
  end
end

class FibonacciIteractively < Minitest::Test
  def setup
    @solution = Solution.new
  end

  def test_the_expected_results
    assert_equal 55, @solution.call(9)
  end
end
