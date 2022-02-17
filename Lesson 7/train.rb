class Train
  include Manufacturer, InstanceCounter
  attr_accessor :name
  attr_accessor :number
  attr_accessor :type
  attr_accessor :route
  attr_accessor :vagons
  attr_reader :current_speed
  attr_reader :current_station_index
  attr_accessor :route_list
  attr_accessor :errors
  attr_reader :block_vagons

  NAME_FORMAT = /[a-z0-9]/i
  NUMBER_FORMAT = /[a-z0-9]{3}-?[a-z0-9]{2}/i

  @@trains = []

  def self.find(number)
    @@trains.find {|train| train.number == number}
  end

  def initialize (name, number)
    @name = name
    @number = number
    validate!
    @type
    @vagons = []
    @current_speed = 0
    @@trains.push(self)
    register_instance
  end

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

  def stations_information
    @route_list = {}
    @route_list['Текущая станция'] = @route.stations[@current_station_index].name
    @current_station_index += 1
    @route_list['Следующая станция'] = @route.stations[@current_station_index].name
    @current_station_index -= 2
    @route_list['Предыдущая станция'] = @route.stations[@current_station_index].name
    @route_list
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
      false
    end
  end

  def train_stopped?
    if @current_speed == 0
      true
    else false
    end
  end

  def show_current_speed
    @current_speed
  end

  def show_current_vagons
    vagons.length
  end

  def valid?
    validate!
    true
    rescue
      false
  end

  def all_vagons (&block)
    @vagons.each {|each_vagon| yield(each_vagon)}
  end

  protected

  def validate!
    @errors = []
    if @name.length < 3
      @errors << "Имя поезда не может быть короче трех символов!"
    end
    if @name !~ NAME_FORMAT
      @errors << "Имя поезда не должно содержать ничего кроме букв и цифр!"
    end
    if @number !~ NUMBER_FORMAT
      @errors << "Номер поезда не совпадает с форматом! Формат номера поезда: три буквы или цифры в любом порядке, необязательный дефис 2 буквы или цифры после дефиса."
    end
    unless @errors.empty?
      puts @errors
      raise @errors.join("|")
    end
  end
end
