class Node
  attr_accessor :value, :children, :word

  PREFIX = 'a'.ord

  def initialize(value)
    @value = value
    @children = Array.new(26)
    @word = false
  end

  def add_or_retrieve(node)
    @children[Node.index_for(node.value)] ||= node
  end

  def self.index_for(char)
    char.ord - PREFIX
  end
end

def search(root, chars)
  return true if root.word && chars.empty?

  char = chars.slice!(0)

  new_root = root.children[Node.index_for(char)]

  if new_root.nil?
    false
  else
    search(new_root, chars)
  end
end

def insert(root, chars)
  chars.each do |char|
    root = root.add_or_retrieve(Node.new(char))
  end

  root.word = true
end

def print(root)
  puts root.value
  root.children.compact.each { |child| print(child) }
end

root = Node.new(nil)

insert(root, 'gabriel'.split(''))
insert(root, 'give'.split(''))
insert(root, 'stephani'.split(''))

print(root)

puts search(root, 'give')
puts search(root, 'gabriel')
puts search(root, 'gustavo')
