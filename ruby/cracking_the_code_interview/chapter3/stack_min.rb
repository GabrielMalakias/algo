require 'minitest/autorun'

# How would you design a stach which, in addition to push and pop, has a function min which returns the minimum element? Push, pop and min should all operate in O(1) time
#
# Approach: Linked List + storing the min item when inserting

class Node
  attr_accessor :value, :next_node

  def initialize(value, next_node)
    @value = value
    @next_node = next_node
  end
end

class Stack
  attr_accessor :root, :min

  def min
    @min&.value
  end

  def pop
    nil if @root.nil?

    value = @root.value
    @root = @root.next_node

    value
  end

  def push(item)
    node = Node.new(item, @root)
    @root = node

    if @min.nil? || @min.value > item
      @min = node
    end

    self
  end
end

class StackMin < Minitest::Test
  def test_the_min_function
    stack = Stack.new.push(5).push(6).push(3)

    assert_equal 3, stack.min
  end

  def test_when_the_stack_is_empty
    stack = Stack.new

    assert_nil stack.min
  end
end
