class Node
  attr_accessor :next

  def initialize(value)
    @value = value
  end

  def to_s
    if @next.nil?
      "|#{@value}|"
    else
      "|#{@value}| ---->"
    end
  end

  def has_next?
    @next != nil
  end
end

string = 'LinkedList'

next_item = nil
previous_node = nil
first_item = nil

string.split('').each do |char|
  node = Node.new(char)

  first_item = node if first_item.nil?

  previous_node.next = node unless previous_node.nil?

  previous_node = node
end

node = first_item

until node.nil?
  print node

  node = node.next
end
