class UnionFind
  attr_accessor :count

  def initialize(number)
    @count = number
    @id = (0..number - 1).to_a
  end

  def union(p, q)
    pId = find(p) # 3
    qId = find(q) # 8

    puts "Before #{@id.inspect}"
    return if pId == qId

    @id.each_with_index do |_value, index|
      @id[index] = qId if @id[index] == pId
    end
    @count -= 1
    puts "After  #{@id.inspect}"
    puts "#{@count} components"
  end

  def find(p)
    @id[p]
  end

  def connected?(p, q)
    find(p) == find(q)
  end
end

number_of_items = 10
list = [[4, 3], [3, 8], [6, 5], [9, 4], [2, 1], [8, 9], [5, 0], [7, 2], [6, 1], [1, 0], [6, 7]]

uf = UnionFind.new(number_of_items)

list.each do |p, q|
  next if uf.connected?(p, q)

  uf.union(p, q)
  puts "#{p} #{q}"
end

puts "#{uf.count} components"
