require_relative './input'

class Node
  attr_accessor :value, :next

  def initialize(value, next_n)
    @value = value
    @next = next_n
  end
end

class Stack
  def initialize
    @root = nil
  end

  def push(value)
    @root = Node.new(value, @root)
  end

  def pop
    if @root.nil?
      nil
    else
      value = @root.value
      @root = @root.next
      value
    end
  end
end


input = array_random_n_numbers(10, 10)
puts input.to_s
stack = Stack.new

input.each { |value| stack.push(value) }

while value = stack.pop
  puts "Value: #{value}"
end
