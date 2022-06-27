require 'minitest/autorun'

# If you are given a list of projects and a list of dependencies,
# (which, is a list of pairs of projects where the second project is dependent on the first project).
# All of a project's dependencies must be built before the project is.
# Find a build a order that will allow the projects to be build.
# If there is no valid build order return an error
# Example:
# input
#    projects: a, b, c, d, e, f
#    dependencies: (a, d), (f, b), (b, d), (f, a), (d, c)
#
# output
#    f, e, a, b, d, c
#
# Approach: BFS (with queue)
# E -> []
# F -> A -> D -> C
#   -> B -> D
#


class Graph
  attr_accessor :adjacent_list

  def initialize(items)
    @adjacent_list = {}

    items.each do |item|
      @adjacent_list[item] = []
    end
  end

  def add_dependant(item, depends_on)
    @adjacent_list[item] = @adjacent_list[item] << depends_on
  end

  def adjacent(item)
    @adjacent_list[item]
  end

  def without_dependencies
    dependent_items = @adjacent_list.values.flatten.uniq

    @adjacent_list.keys.select { |item| !dependent_items.include?(item) }
  end


  def items_size
    @adjacent_list.keys.size
  end
end

class Solution
  CircularDependencyError = Class.new(StandardError)

  def call(graph)
    solved_dependencies = []
    queue = []

    graph.without_dependencies.reverse.each do |item|
      queue.push(item)
    end

    while !queue.empty?
      current = queue.delete_at(0)

      # Visit
      if !solved_dependencies.include?(current)
        solved_dependencies << current
      end

      graph.adjacent(current).each do |item|
        queue.push(item)
      end
    end

    raise CircularDependencyError, 'Error detected' if solved_dependencies.size != graph.items_size

    solved_dependencies
  end
end

class BuildOrderTest < Minitest::Test
  def setup
    @graph = Graph.new(['a', 'b', 'c', 'd', 'e', 'f'])

    @solution = Solution.new
  end

  def test_nodes_without_dependencies
    @graph.add_dependant('f', 'a')

    assert_equal @graph.without_dependencies, ['b', 'c', 'd', 'e', 'f']
  end

  def test_when_an_item_is_added
    @graph.add_dependant('f', 'a')
    @graph.add_dependant('f', 'b')

    assert_equal @graph.adjacent_list['f'], ['a', 'b']
  end

  def test_when_the_build_order_contains_a_solution
    @graph.add_dependant('f', 'a')
    @graph.add_dependant('f', 'b')
    @graph.add_dependant('a', 'd')
    @graph.add_dependant('b', 'd')
    @graph.add_dependant('d', 'c')

    assert_equal ['f', 'e', 'a', 'b', 'd', 'c'], @solution.call(@graph)
  end

  def test_when_the_build_order_does_not_contain_a_solution
    @graph.add_dependant('f', 'a')
    @graph.add_dependant('a', 'f')
    @graph.add_dependant('f', 'b')
    @graph.add_dependant('a', 'd')
    @graph.add_dependant('b', 'd')
    @graph.add_dependant('d', 'c')

    assert_raises(Solution::CircularDependencyError) do
      @solution.call(@graph)
    end
  end
end
