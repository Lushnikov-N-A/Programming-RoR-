class Route
  
  attr_accessor :stations

  def initialize(first_station, last_station)
    @stations = [first_station, last_station]
  end

  def pushning_intermediate_stations(station)
    index = @stations.length - 1
    @stations.insert(index,station)
  end

  def deleting_intermediate_stations(station)
    @stations.delete(station)
  end

  def print_list_station
    puts "Список станций:"
    @stations.each_with_index {|station, index|
    puts "Станция #{(index +1)} #{station}"
    }
  end

end


