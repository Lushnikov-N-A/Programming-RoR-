class Train
  attr_accessor :name
  attr_accessor :type
  attr_accessor :route
  attr_accessor :vagons
  attr_reader :current_speed
  attr_reader :current_station_index
  def initialize (name)
    @name = name
    @type
    @vagons = []
    @current_speed = 0
  end
#Public, т.к. вызываются "из другого объекта".
  def push_vagon(vagon)
    if train_stopped? && check_vagon(vagon)
      self.vagons.push(vagon)
  end
  end
  def delete_vagon
    if train_stopped? && (self.vagons.length>0)
      self.vagons.pop
    end
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
  def speed_up(speed)
    @current_speed = @current_speed + speed
  end
  def stop
    @current_speed = 0
  end
  def check_vagon(vagon)
    if vagon.type == self.type
      true
    else
      puts "Данный вагон не подходит к поезду"
      false
    end
  end
  def train_stopped?
    if @current_speed == 0
      true
    else false
      "Поезд едет, изменение числа вагонов невозможно"
    end
  end
  def show_current_speed
    puts "Текущая скорость у поезда #{@name} = #{@current_speed}"
  end
  def show_current_vagons
    puts "Количество вагонов у поезда #{@name}  = #{vagons.length}"
  end
end
