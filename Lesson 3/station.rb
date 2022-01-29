class Station
  attr_accessor :list_of_trains
  attr_accessor :station_name

  def initialize (station_name)
    @station_name = station_name
    @list_of_trains = []
  end

  def reception_trains(train)
    @list_of_trains.push(train)
  end 

  def puts_trains(train)
    @list_of_trains.delete(train)
  end


  def print_list_trains
    puts "На станции #{self.station_name} находятся поезда:"
    @list_of_trains.each_with_index {|train, index|
    puts "Поезд #{(index +1)} #{train.name_train}"
    }
  end

  def trains_of_type (type_train)
    i=0
    puts "Список поездов по типу #{type_train}:"
    @list_of_trains.each_with_index {|train, index|
      if train.type_train == type_train
        i+=1
        puts " Поезд #{(index +1)} #{train.name_train}"
      end
      }
    puts "Количество поездов #{type_train} = #{i}"
  end

end


