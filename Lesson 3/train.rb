class Train
  attr_accessor :name_train
  attr_accessor :type_train
  attr_accessor :route_train

  def initialize (name_train, type_train, vagons)
    @name_train = name_train
    @type_train = type_train
    @vagons = vagons
    @current_speed = 0
  end

  def speed_up(speed)
    @current_speed = @current_speed + speed
  end 

  def stop 
    @current_speed = 0
  end 

  def change_vagons(i)
    if (@current_speed == 0)&&(i>0)
      @vagons +=1
    elseif @current_speed != 0
      puts "Текущая скорость = #{@current_speed}, изсенение числа вагонов невозможно!"
    elseif (@current_speed == 0)&&(i<0)
      @vagons -=1
    end
  end

  def show_current_speed
    puts "Текущая скорость у поезда #{@name_train} = #{@current_speed}"
  end 

  def show_current_vagons
    puts "Количество вагонов у поезда #{@name_train}  = #{@vagons}"
  end 

  def print_list_station
    puts "Список станций:"
    @list_of_stations.each_with_index {|station, index|
    puts " Станция #{(index +1)} #{station}"
    }
  end

  def put_route(route)
    @route_train = route
    #puts "Маршрут назначен #{route.list_of_stations}"
    @route_train.list_of_stations[0].reception_trains(self)
  end

  def train_go(n)
    case 
      when n == "+"
        i=1
      @route_train.list_of_stations.each_with_index {|station,n|
          station.list_of_trains.each_with_index {|train| 
          if train == self
            station.puts_trains(self)
            i+=n
          end
      }
      }
    @route_train.list_of_stations[i].reception_trains(self)
      
    when n == "-"
        i = 0
      @route_train.list_of_stations.each_with_index {|station,n|
          station.list_of_trains.each_with_index {|train| 
          if train == self
            station.puts_trains(self)
            i = n - 1
          end
      }
      }
    @route_train.list_of_stations[i].reception_trains(self)
    end
  end

  def train_station
    i = 0
    @route_train.list_of_stations.each_with_index {|station,n|
          station.list_of_trains.each_with_index {|train| 
          if train == self
          puts "Поезд #{self.name_train} находится на станции #{station.station_name}"  
          i = n-1
          puts "Предыдущая станция поезда #{self.name_train} - #{route_train.list_of_stations[i].station_name}"
          i = n+1
          puts "Следующая станция поезда #{self.name_train} - #{route_train.list_of_stations[i].station_name}"
          end
      }
      }
  end
end


