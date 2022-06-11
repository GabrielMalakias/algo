# timeseries = [[1, 0, 0, 1], [0 ,1 ,0, 1]] # valid

timeseries = [[1, 0, 0, 0, 1], [1, 0, 1, 0, 0]] # invalid

# timeseries = [[1, 0, 1, 0, 1], [1, 0, 1, 0, 0]] # invalid

def valid?(timeseries)
  timeseries_map = timeseries
    .map { |positions| collect_positions(positions) }

  validate_positions(timeseries_map)
end

def validate_positions(positions)
  temporary = {}

  positions.each_with_index do |map, index|
    if index == 0
      temporary = map
    else
      return false if temporary.length != map.length
      map.each do |key, value|
        return false if (temporary[key] - value).abs > 1
      end
    end
  end

  return true
end

def collect_positions(positions)
  previous_position = { }
  counter = 0

  positions.each_with_index do |value, index|
    if value == 1
      previous_position = previous_position.merge({counter => index})
      counter = counter + 1
    end
  end

  previous_position
end


puts valid?(timeseries).inspect
