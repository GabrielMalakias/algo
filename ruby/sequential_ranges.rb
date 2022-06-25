require 'minitest/autorun'

# Given an string like '1, 3, 4, 5, 7, 8, 10, returns its groups
# Example 1, 1 | 3, 5 | 7, 2 | 10

class Item
  attr_accessor :start_value, :number_of_items

  def initialize(start_value)
    @start_value = start_value
  end

  def to_a
    [@start_value, @number_of_items]
  end
end


class FindRanges
  def call(string)
    array = string_to_array(string)

    current_node = nil
    number_of_items = 1
    result = []

    array.each_with_index do |value, index|
      if current_node.nil?
        current_node = Item.new(value)
      end
     item.strip.to_i
    end
  end
end

class FindRangesTest < Minitest::Test
  def setup
    @find_ranges = FindRanges.new
  end

  def test_ranges_are_found
    assert_equal [[1, 1], [3, 3], [7, 2], [10, 1]], @find_ranges.call('1, 3, 4, 5, 7, 8, 10')
  end

  def test_only_a_single_number
    assert_equal [[1, 1]], @find_ranges.call('1')
  end

  def test_empty_list
    assert_equal [], @find_ranges.call('')
  end
end
