string = ARGV[0]

indexes = []
string.split("").each_with_index do |char, index|
    indexes << index if char == "|"
end

count = 0

indexes.slice(0..-2).each_with_index do |value, index|
    count = indexes[index + 1] - value - 1 + count
end

# ||*||***||**| => 6
# ||*||**** => 1
puts "In the string #{string} there are * #{count} enclosed"
