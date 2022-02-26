# frozen_string_literal: true

class Train
  include InstanceCounter
  include Manufacturer
  attr_accessor :name, :number, :type, :route, :vagons, :route_list, :errors
  attr_reader :current_speed, :current_station_index, :block_vagons

  NAME_FORMAT = /[a-z0-9]/i.freeze
  NUMBER_FORMAT = /[a-z0-9]{3}-?[a-z0-9]{2}/i.freeze

  def self.find(number)
    @trains.find { |train| train.number == number }
  end

  def initialize(name, number)
    @name = name
    @number = number
    validate!
    @type ||= ''
    @vagons = []
    @current_speed = 0
    @trains ||= []
    @trains.push(self)
    register_instance
  end

  def push_vagon(vagon)
    vagons.push(vagon) if train_stopped? && check_vagon(vagon)
  end

  def delete_vagon
    vagons.pop if train_stopped? && vagons.length.positive?
  end

  def put_route(route)
    @route = route
    @current_station_index = 0
    @route.stations[@current_station_index].reception_trains(self)
  end

  def train_go(nav)
    case nav
    when '+'
      @route.stations[@current_station_index].puts_trains(self)
      @current_station_index += 1
      @route.stations[@current_station_index].reception_trains(self)
    when '-'
      @route.stations[@current_station_index].puts_trains(self)
      @current_station_index -= 1
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
    @current_speed += speed
  end

  def stop
    @current_speed = 0
  end

  def check_vagon(vagon)
    vagon.type == type
  end

  def train_stopped?
    @current_speed.zero?
  end

  def show_current_speed
    @current_speed
  end

  def show_vagons
    vagons.length
  end

  def valid?
    validate!
    true
  rescue StandardError
    false
  end

  def all_vagons(&block)
    @vagons.each(&block)
  end

  protected

  def validate!
    @errors = []
    @errors << 'Имя поезда не может быть короче трех символов!' if @name.length < 3
    @errors << 'Имя поезда не должно содержать ничего кроме букв и цифр!' if @name !~ NAME_FORMAT
    if @number !~ NUMBER_FORMAT
      @errors << 'Номер не совпадает с форматом: 3 буквы или цифры в любом порядке, "-" 2 буквы или цифры после "-".'
    end
    return if @errors.empty?

    puts @errors
    raise @errors.join('|')
  end
end
