require 'minitest/autorun'

# Imagine a literal stack of plates. If the stack gets too high, it might topple. Therefore,
# in real life, we would likely start a new stack when the previous stack exceeds some threshold.
# Implement a data structure SetOfStacks that mimics this, SetOfStacks should be composed of several stacks
# and should create a new stack once the previous one exceeds capacity of SetOfStacks. push() and pop() should behave identically
# to a single stack (that is pop() should return the same values as it would if there were just a single stack)
#
# Extra: Implement a function popAt(index) which performs a pop operation on a specific sub-stack

class SetOfStacks
  attr_reader :max
  def initialize(max)
    @max = max
  end
end

class SetOfStacksTest < Minitest::Test
  def setup
    @stacks = SetOfStacks.new(2)
  end

  def test_push_and_pop_behaves_correctly
    @stacks.push(2).push(3).push(4)

    assert_equal @stacks.pop(), 4
    assert_equal @stacks.pop(), 3
    assert_equal @stacks.pop(), 2
    assert_nil @stacks.pop()
  end
end
