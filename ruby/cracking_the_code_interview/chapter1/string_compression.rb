require 'minitest/autorun'

# Implement a method to perform basic string compression using the counts of repeated characters
#
#
# Approach: Pointer and buffer
# Example:
# aabcccccaaa -> a2b1c5a3
# abc -> abc
#
# Approach:
# Time complexity: O(N)
#
class Solution
  def call(string)
    compressed_string = ''
    count = 0
    index = 0

    while index <= string.length
      previous_index = index == 0 ? 0 : index - 1

      if string[previous_index] == string[index]
        count += 1
      else
        compressed_string += "#{string[previous_index]}#{count}"
        count = 1
      end

      index += 1
    end

    compressed_string.length < string.length ? compressed_string : string
  end
end

class OneAway < Minitest::Test
  def setup
    @solution = Solution.new
  end

  def test_when_compressed_word_is_smaller
    assert_equal 'a2b1c5a3', @solution.call('aabcccccaaa')
  end

  def test_when_compressed_word_is_bigger
    assert_equal 'abc', @solution.call('abc')
  end
end
