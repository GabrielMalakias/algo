require 'minitest/autorun'

# Write an algorithm such that if an element in an M X N matrix is 0, its entire row and column are set to 0;
#
# Before
#
# 1 1 1 1
# 1 3 0 1
# 1 0 1 3
# 1 3 3 4
#
# After
# 1 0 0 1
# 0 0 0 0
# 0 0 0 3
# 1 0 0 4
#
class Solution
  def call(matrix)
    rows = []
    columns = []

    matrix.each_with_index do |row, i|
      row.each_with_index do |value, j|
        if value == 0
          rows << i
          columns << j
        end
      end
    end

    columns.uniq.each do |j|
      matrix.each_with_index do |_, i|
        if rows.include?(i)
          matrix[i] = Array.new(matrix.first.length) { |_| 0 }
        else
          matrix[i][j] = 0
        end
      end
    end

    matrix
  end
end

class ZeroMatrix < Minitest::Test
  def setup
    @solution = Solution.new
  end

  def test_when_the_matrix_contains_a_zero
    input = [[1, 1, 1, 1],
             [1, 3, 3, 1],
             [1, 1, 1, 3],
             [1, 1, 3, 0]]

    expectation = [[1, 1, 1, 0],
                   [1, 3, 3, 0],
                   [1, 1, 1, 0],
                   [0, 0, 0, 0]]

    assert_equal expectation, @solution.call(input)
  end

  def test_when_the_matrix_contains_two_zeros
    input = [[1, 1, 1, 1],
             [1, 3, 0, 1],
             [1, 0, 1, 3],
             [1, 3, 3, 4]]

    expectation = [[1, 0, 0, 1],
                   [0, 0, 0, 0],
                   [0, 0, 0, 0],
                   [1, 0, 0, 4]]

    assert_equal expectation, @solution.call(input)
  end

  def test_when_the_matrix_contains_no_zeros
    input = [[1, 1, 1, 1],
             [1, 3, 3, 1],
             [1, 1, 1, 3],
             [1, 1, 3, 3]]

    assert_equal input, @solution.call(input)
  end
end
