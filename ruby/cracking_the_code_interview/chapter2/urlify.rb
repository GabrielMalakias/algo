require 'minitest/autorun'

# Write a method to replace all spaces in a string with '%20'
#
# Approach: Find and sub
#
# Go though the string identifying indexes storing ranges and rebuilding the string later
#

class Solution
  def call(string)
    return string if string.empty?

    indexes = []

    string.split("").each_with_index do |char, index|
      indexes << index if char == " "
    end

    current_index = 0
    result = ""
    indexes.each do |index|
      result = result + string[current_index..index - 1] + "%20"

      current_index = index + 1
    end

    result = result + string[current_index..string.length]

    result
  end
end

class Urlify < Minitest::Test
  def setup
    @solution = Solution.new
  end

  def test_when_the_string_is_empty
    assert_equal "", @solution.call("")
  end

  def test_when_the_string_contain_spaces
    assert_equal "John%20Doe%20Bad", @solution.call('John Doe Bad')
  end
end
