require_relative './input'

class Fifo
  def initialize
    @array = []
  end

  def enqueue(value)
    @array << value
  end

  def dequeue
    @array.empty? ? nil : @array.delete_at(0)
  end

  def to_s
    @array.to_s
  end
end

queue = Fifo.new
input = array_random_n_numbers(10, 10)

input.each { |value| queue.enqueue(value) }

puts "Original #{queue}"
while value = queue.dequeue
  puts "Value #{value}"
end
puts "End #{queue}"
