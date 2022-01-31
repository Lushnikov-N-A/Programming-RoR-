class Train
  attr_accessor :name
  attr_accessor :type
  attr_accessor :route

  def initialize (name, type, vagons)
    @name = name
    @type = type
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
    puts "Текущая скорость у поезда #{@name} = #{@current_speed}"
  end

  def show_current_vagons
    puts "Количество вагонов у поезда #{@name}  = #{@vagons}"
  end

  def print_list_station
    puts "Список станций:"
    @stations.each_with_index {|station, index|
    puts "Станция #{(index +1)} #{station}"
    }
  end

  def put_route(route)
    @route = route
    @current_station_index = 0
    @route.stations[@current_station_index].reception_trains(self)

  end


  def train_go(n)
    case
      when n == "+"
        @route.stations[@current_station_index].puts_trains(self)
        @current_station_index +=1
        @route.stations[@current_station_index].reception_trains(self)
    when n == "-"
        @route.stations[@current_station_index].puts_trains(self)
        @current_station_index -=1
        @route.stations[@current_station_index].reception_trains(self)
    end
  end

  def train_station
    puts "Поезд #{self.name} находится на станции #{@route.stations[@current_station_index].name}"
    @current_station_index += 1
    puts "Следующей станцией поезда #{self.name} является #{@route.stations[@current_station_index].name}"
    @current_station_index -= 2
    puts "Предыдущей станцией поезда #{self.name} является #{@route.stations[@current_station_index].name}"
  end
end
