require 'minitest/autorun'

# Given two strings, write a function to check if they are one edit (or zero edits) away
#
# Example:
# pale, ple -> true
# pales, pale -> true
# pale, bale -> true
# pale, bake -> false
#
# Approach:
# Time complexity O(N + M)
# Space complexity O(X) where x is the number of unique letters
#
class Solution
  def call(first, second)
    return false if (first.length - second.length).abs > 1

    hash = {}.tap do |h|
      count_word_letters(h, first)
      count_word_letters(h, second)
    end

    different_letters = []
    hash.each do |key, value|
      next if value.even?

      different_letters << key
    end

    different_letters.length > 2 ? false : true
  end

  def count_word_letters(hash, word)
    word.split("").each { |w| add_to_key(hash, w) }
  end

  def add_to_key(hash, letter)
    hash.tap do |h|
      h[letter] = h[letter].to_i + 1
    end
  end
end

class OneAway < Minitest::Test
  def setup
    @solution = Solution.new
  end

  def test_when_the_words_are_one_insert_away
    assert_equal true, @solution.call('pale', 'ple')
  end

  def test_when_the_words_are_one_insert_away_2
    assert_equal true, @solution.call('pales', 'pale')
  end

  def test_when_the_words_are_one_replace_away
    assert_equal true, @solution.call('pale', 'bale')
  end

  def test_when_the_words_are_two_replaces_away
    assert_equal false, @solution.call('pale', 'bake')
  end

  def test_when_the_words_are_two_inserts_away
    assert_equal false, @solution.call('pale', 'ae')
  end

  def test_when_the_words_are_one_insert_away_3
    assert_equal true, @solution.call('cool', 'lool')
  end

  def test_when_the_words_are_one_insert_and_replace_away
    assert_equal false, @solution.call('cool', 'lol')
  end
end
