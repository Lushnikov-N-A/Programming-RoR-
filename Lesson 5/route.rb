class Route
  include InstanceCounter
  attr_accessor :stations
  attr_accessor :name

  def initialize(first_station, last_station)
    @stations = [first_station, last_station]
    @name=""
    register_instance
  end

#Public
#Методы должны быть публичными, т.к. вызываются извне
  def name_route(name)
    @name = name
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
    @stations.each_with_index do |station, index|
      puts "Станция #{(index +1)} #{station.name}"
    end
  end
end
