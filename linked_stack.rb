class Node
  attr_accessor :value, :next

  def initialize(value, next_n)
    @value = value
    @next = next_n
  end
end

class LinkedStack
  def initialize
    @root = nil
  end

  def push(value)
    @root = Node.new(value, @root)
  end

  def pop
    if @root.nil?
      nil
    else
      value = @root.value
      @root = @root.next
      value
    end
  end
end
