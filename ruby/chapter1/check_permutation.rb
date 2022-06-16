require 'minitest/autorun'

# Given two strings, write a method to decide if one is a permutation of the other
#
#
# Approach: Window spacing
# For example:
# a = absc
# b = aljsljbslsabcsslajh
#
# Go through the string applying permutation with the length of a

class Solution
  def call(first_string, second_string)
    return false if first_string.length > second_string.length

    first_length = first_string.length

    second_string_array = second_string.split("")

    (0..second_string_array.length).each do |index|
      result = second_string_array.slice(index..(index + first_length)).permutation.to_a & [first_string.split("")]

      return true if !result.empty?
    end

    false
  end
end

class CheckPermutation < Minitest::Test
  def setup
    @solution = Solution.new
  end

  def test_when_b_is_smaller_than_a
    assert_equal false, @solution.call("abs", "ab")
  end

  def test_that_a_is_contained_within_b
    assert_equal false, @solution.call("abc", "aljsljbslsacbsslajh")
  end

  def test_that_a_is_not_contained_within_b
    assert_equal false, @solution.call("abc", "bdkjkahlbahhklawsk")
  end
end
