require 'minitest/autorun'

# Write a program to sort a stack such that the smallest items are on the top.
# You can use an aditional temporary stack,
# but you may not copy the elements into any other data structure (such as an array). The stack supports the following operations: push, pop, peek and empty?
#
# Example:
#
# 2 -> Stack(2)
# 3 -> Stack(2, 3)
# 1 -> Stack(1, 2, 3)
# 8 -> Stack(1, 2, 3, 8)

class Node
  attr_accessor :value, :next_value

  def initialize(value, next_value)
    @value = value
    @next_value = next_value
  end
end

class Stack
  attr_accessor :root

  def push(value)
    @root = Node.new(value, @root)

    self
  end

  def pop
    return if empty?

    value = @root.value
    @root = @root.next_value
    value
  end

  def peek
    @root&.value
  end

  def empty?
    @root.nil?
  end
end

class SortedStack
  attr_accessor :stack, :temp_stack

  def initialize
    @stack = Stack.new
    @temp_stack = Stack.new
  end

  def push(value)

    if @stack.empty? || @stack.peek > value
      @stack.push(value)
    else
      while !@stack.empty? && @stack.peek < value
        @temp_stack.push(@stack.pop)
      end

      @stack.push(value)

      while !@temp_stack.empty?
        @stack.push(@temp_stack.pop)
      end
    end

    value
  end

  def pop
    @stack.pop
  end

  def peek
    @stack.peek
  end

  def empty?
    @stack.empty?
  end
end

class SortStackTest < Minitest::Test
  def setup
    @stack = SortedStack.new
  end

  def test_when_a_bigger_element_is_pushed
    @stack.push(2)
    @stack.push(3)

    assert_equal @stack.pop, 2
    assert_equal @stack.pop, 3
  end

  def test_when_a_smaller_element_is_pushed
    @stack.push(2)
    @stack.push(3)
    @stack.push(1)

    assert_equal @stack.pop, 1
    assert_equal @stack.pop, 2
    assert_equal @stack.pop, 3
  end

  def test_when_stack_is_empty
    assert @stack.empty?

    @stack.push(1)

    assert_equal @stack.empty?, false
  end

  def test_big_scenario
    @stack.push(2)
    @stack.push(3)
    @stack.push(1)
    @stack.push(8)

    assert_equal @stack.pop, 1
    assert_equal @stack.pop, 2
    assert_equal @stack.pop, 3
    assert_equal @stack.pop, 8
  end
end
