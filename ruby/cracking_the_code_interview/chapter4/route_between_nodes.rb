require 'minitest/autorun'

# Given a directed graph and two nodes (S and E), design an algorithm to find out whether there is a route from S to E
# Example:  S -> B
#           B -> D
#           D -> E
#           S -> C
#           C -> D
# returns true because S -> B -> D -> E
#
# Approach: DFS
#
class Node
  attr_accessor :value, :connections, :visited

  def initialize(value)
    @value = value
    @visited = false
    @connections = []
  end

  def add(edge)
    @connections << edge
  end

  def visited!
    @visited = true
  end

  def visited?
    @visited
  end
end

class Graph
  attr_accessor :nodes

  def initialize
    @nodes = {}
  end

  def add_connection(edge_a, edge_b)
    current_or_new(edge_a).add(current_or_new(edge_b))
    current_or_new(edge_b).add(current_or_new(edge_a))

    self
  end

  def call(edge_a, edge_b)
    dfs(@nodes[edge_a])

    current_or_new(edge_b).visited?
  end

  private

  def dfs(root)
    root.visited!

    root.connections.each do |node|
      dfs(node) if !node.visited?
    end
  end

  def current_or_new(edge)
    if @nodes[edge].nil?
      node = Node.new(edge)
      @nodes[edge] = node
    end

    return @nodes[edge]
  end
end

class GraphTest < Minitest::Test
  def setup
    @graph = Graph.new
  end

  def test_when_there_is_a_path_between_two_points
    @graph
      .add_connection('S','B')
      .add_connection('B','C')
      .add_connection('D','E')
      .add_connection('S','C')
      .add_connection('C','D')

    assert_equal @graph.call('S', 'E'), true
  end

  def test_when_there_is_no_path_between_two_points
    @graph
      .add_connection('S','B')
      .add_connection('B','C')
      .add_connection('S','C')
      .add_connection('C','D')

    assert_equal @graph.call('S', 'E'), false
  end
end
