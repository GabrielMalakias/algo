require_relative './input'

class Node
  attr_accessor :value, :next

  def initialize(value, next_i)
    @value = value
    @next = next_i
  end
end

class Bag
  def initialize
    @size = 0
  end

  def add(value)
    @size += 1
    @root = Node.new(value, @root)
  end

  def reduce(acc, &block)
    return unless block_given?

    current = @root

    until current.nil?
      acc = block.call(current.value, acc)
      current = current.next
    end

    acc
  end

  def sum
    reduce(0) { |value, acc| acc + value }
  end

  def empty?
    @root.nil?
  end

  attr_reader :size

  def to_s
    "Items: #{reduce('') { |value, acc| acc = acc << (',' << value.to_s) }}\n" \
    "size: #{size}\n" \
    "sum: #{sum}"
  end
end

class Stats
  def call
    input = array_random_n_numbers(20, 10)

    bag = Bag.new

    input.each do |value|
      bag.add(value)
    end

    mean_result = mean(bag)

    puts bag
    puts "Mean: #{mean_result}"
    puts "Standard Deviation: #{standard_deviation(mean_result, bag)}"
  end

  private

  def mean(bag)
    bag.sum / bag.size
  end

  def standard_deviation(mean_result, bag)
    sum = bag.reduce(0) { |value, _acc| acc = (value - mean_result) * (value - mean_result) }
    Math.sqrt(sum)
  end
end

Stats.new.call
