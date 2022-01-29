class Route
  attr_accessor :list_of_stations

  def initialize (first_station, last_station)
    @list_of_stations = []
    @first_station = first_station
    @last_station = last_station
    @list_of_stations[0] = @first_station
    @list_of_stations << @last_station
  end

  def pushning_intermediate_stations (index, station)
    index -= 1
    @list_of_stations.insert(index,station)
  end 

  def deleting_intermediate_stations (station)
    @list_of_stations.delete(station)
  end 


  def print_list_station
    puts "Список станций:"
    @list_of_stations.each_with_index {|station, index|
    puts " Станция #{(index +1)} #{station.station_name}"
    }
  end

end


