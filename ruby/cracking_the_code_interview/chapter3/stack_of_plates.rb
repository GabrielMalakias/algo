require 'minitest/autorun'

# Imagine a literal stack of plates. If the stack gets too high, it might topple. Therefore,
# in real life, we would likely start a new stack when the previous stack exceeds some threshold.
# Implement a data structure SetOfStacks that mimics this, SetOfStacks should be composed of several stacks
# and should create a new stack once the previous one exceeds capacity of SetOfStacks. push() and pop() should behave identically
# to a single stack (that is pop() should return the same values as it would if there were just a single stack)
#
# Extra: Implement a function popAt(index) which performs a pop operation on a specific sub-stack
#
class Node
  attr_accessor :value, :next_node

  def initialize(value, next_node)
    @value = value
    @next_node = next_node
  end
end

class Stack
  attr_accessor :root, :size

  def initialize
    @size = 0
  end

  def push(value)
    @root = Node.new(value, @root)
    @size = @size + 1

    self
  end

  def peek
    @root
  end

  def pop
    return if empty?

    value = @root.value
    @root = @root.next_node

    value
  end

  def empty?
    @root.nil?
  end
end

class SetOfStacks
  attr_reader :max, :stacks

  def initialize(max)
    @max = max
    @stacks = Stack.new
  end

  def push(value)
    if @stacks.empty? || @stacks.peek.value.size == @max
      @stacks.push(Stack.new)
    end

    @stacks.peek.value.push(value)

    self
  end

  def pop
    return if @stacks.empty?

    @stacks.pop if @stacks.peek.value.empty?

    return if @stacks.peek.nil?

    value = @stacks.peek.value.pop()
    @stacks.pop if @stacks.peek.value.empty?

    value
  end
end

class SetOfStacksTest < Minitest::Test
  def setup
    @set = SetOfStacks.new(2)
  end

  def test_push_and_pop_behaves_correctly
    @set.push(2).push(3).push(4)

    assert_equal @set.pop(), 4
    assert_equal @set.pop(), 3
    assert_equal @set.pop(), 2
    assert_nil @set.pop()
  end

  def test_stacks_contains_two_stacks
    @set.push(2).push(3).push(4)

    assert_equal @set.stacks.peek().value.size, 1
    @set.pop
    assert_equal @set.stacks.peek().value.size, 2
  end
end
