# frozen_string_literal: true

class Route
  include InstanceCounter
  attr_accessor :stations, :name

  NAME_FORMAT = /[a-z]/i.freeze

  # Валидация имен станций и количесвта станций не производится,
  # т.к. валидация имен станций проводится при создании экземпляра класса Station,
  # а количество аргументов проверяется автоматически.
  # Сделал валидацию имени маршрута для отдельного метода.

  def initialize(first_station, last_station)
    @stations = [first_station, last_station]
    register_instance
  end

  def name_route(name)
    validate!(name)
    @name = name
  end

  def ins_stations(station)
    index = @stations.length - 1
    @stations.insert(index, station)
  end

  def del_stations(station)
    @stations.delete(station)
  end

  def print_list_station
    puts 'Список станций:'
    @stations.each_with_index do |station, index|
      puts "Станция #{index + 1} #{station.name}"
    end
  end

  def valid?
    validate!(name)
    true
  rescue StandardError
    false
  end

  protected

  def validate!(name)
    raise 'Имя маршрута не может быть короче трех символов!' if name.length < 3
    raise 'Имя маршрута не должно содержать ничего кроме букв!' if name !~ NAME_FORMAT
  end
end
