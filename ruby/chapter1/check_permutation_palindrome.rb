require 'minitest/autorun'

# Checks if a string has a permutation which is a palindrome
#
#
# Example: abba, acaca, babac, abbbbba, abbbcba => true
# abc, aabbccdy, abbyyi => false
#
# Approach: Count the number of letters and verify id all numbers are odd or there is just one even
#
# Time complexity O(N + M)
# Where N is the number of letters
# M is the number of unique letters
#
class Solution
  def call(string)
    letter_map = {}

    string.split("").each do |letter|
      letter_map[letter] = letter_map[letter].to_i + 1
    end

    odd = false
    letter_map.each do |key, value|
      next if value.even?

      if odd
        return false
      else
        odd = true
      end
    end

    true
  end
end

class CheckPermutationPalindrome < Minitest::Test
  def setup
    @solution = Solution.new
  end

  def test_when_the_word_has_palindrome_with_even
    assert_equal true, @solution.call("abab")
  end

  def test_when_the_word_has_palindrome_with_odd
    assert_equal true, @solution.call("acbba")
  end

  def test_whe_the_word_has_palindrome_case_1
    assert_equal true, @solution.call("abbbcba")
  end

  def test_when_the_word_hasnt_palindrome_case_1
    assert_equal false, @solution.call("abc")
  end

  def test_when_word_hasnt_palindrome_case_2
    assert_equal false, @solution.call("abbyyi")
  end
end
