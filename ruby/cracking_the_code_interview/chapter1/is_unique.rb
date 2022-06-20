require 'minitest/autorun'

# Implement an algorithm to determine if a string has all unique characters
#
# Approach: Sort the string and use a buffer to the previous value
#
# Time complexity: O(n)
# Space complexity: O(n)
#
class Solution
  def call(string)
    previous_char = nil

    string.split('').sort.each do |char|
      return false if previous_char == char

      previous_char = char
    end

    true
  end
end

class IsUniqueTest < Minitest::Test
  def setup
    @solution = Solution.new
  end

  def test_that_testing_returns_false
    assert_equal false, @solution.call('testing')
  end

  def test_that_uniq_returns_true
    assert_equal true, @solution.call('uniq')
  end
end
