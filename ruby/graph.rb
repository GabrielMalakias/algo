class Graph
  attr_reader :vertex, :number_of_edges

  def initialize
    @vertex = {}
    @number_of_edges = 0
  end

  def add(x, y)
    @vertex[x] = Array(@vertex[x]) << y
    @vertex[y] = Array(@vertex[y]) << y

    @number_of_edges += 1
  end

  def adjacent(edge)
    @vertex[edge]
  end
end

class DepthFirstSearch
  attr_reader :origin, :marked, :edge_to

  def initialize(graph, origin)
    @origin = origin
    @edge_to = {}
    @graph = graph

    @marked = (0..graph.number_of_edges).each_with_object({}) do |i, hash|
      hash[i] = false
    end

    evaluate(@origin)
  end

  def connected_to?(destination)
    @marked[destination]
  end

  def evaluate(edge)
    @marked[edge] = true

    @graph.adjacent(edge).each do |destination|
      unless @marked[destination]
        @edge_to[destination] = edge
        evaluate(destination)
      end
    end
  end

  def path_to(destination)
    return nil unless connected_to?(destination)

    path = []

    current = destination
    while current != @origin
      current = @edge_to[current]
      path << current
    end

    path = [destination] + path

    path.reverse.join(' -> ')
  end
end

graph = Graph.new

# Load values
%w[0-1 0-2 2-4 1-3 3-4 0-3].each do |connection|
  x, y = connection.split('-')
  graph.add(x.to_i, y.to_i)
end

zero_dfs = DepthFirstSearch.new(graph, 0)
