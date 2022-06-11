class BinarySearch
  def initialize(array)
    @array = array
  end

  def index_of(key:)
    first = 0
    last = @array.size - 1

    while first <= last
      middle = first + (last - first) / 2

      puts "Middle: #{middle} First: #{first} Last #{last}"
      if key < @array[middle]
        last = middle - 1
      elsif key > @array[middle]
        first = middle + 1
      else
        return middle
      end
    end
  end
end

puts BinarySearch.new([1, 3, 4, 5, 7]).index_of(key: 5)
