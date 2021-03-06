class ThreeSum
  def count(array)
    size = array.length
    count = 0

    i = 0
    while i < size
      j = i + 1
      while j < size
        k = j + 1
        while k < size
          puts "i: #{i} j: #{j} k: #{k}"
          count += 1 if array[i] + array[j] + array[k] == 0
          k += 1
        end
        j += 1
      end

      i += 1
    end
    count
  end
end

array = (0..5).map { |_i| rand(-1_000_000..1_000_000) }

puts ThreeSum.new.count(array)
