class Node
  attr_accessor :value, :left, :right

  def initialize(value)
    @value = value
  end

  def value
    @value.to_i
  end
end

def insert(root, value)
  if root.nil?
    return Node.new(value)
  end

  if root.value > value.to_i
    root.left = insert(root.left, value)
  else
    root.right = insert(root.right, value)
  end

  root
end

def print(root)
  return if root.nil?

  print(root.left)
  puts root.value
  print(root.right)
end

string = '5,6,8,2,1'

leafs = string.split(",")

first = Node.new(leafs.pop)

leafs.each { |leaf| insert(first, leaf.to_i) }

print(first)
