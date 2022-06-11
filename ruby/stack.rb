require_relative './input'
require_relative './linked_stack'

input = array_random_n_numbers(10, 10)
puts input.to_s
stack = LinkedStack.new

input.each { |value| stack.push(value) }

while value = stack.pop
  puts "Value: #{value}"
end
