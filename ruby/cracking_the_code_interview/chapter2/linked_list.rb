class Node
  attr_accessor :next_node, :value

  def initialize(value, next_node)
    @value = value
    @next_node = next_node
  end
end

class LinkedList
  attr_accessor :root

  def push(value)
    node = Node.new(value, root)
    @root = node

    self
  end

  def to_a
    node = @root
    array = []

    until node.nil?
      array << node.value

      node = node.next_node
    end

    array.reverse
  end

  def empty?
    @root.nil?
  end
end
