# frozen_string_literal: true

class Station
  include InstanceCounter
  attr_accessor :trains, :name, :list_trains, :all_stations
  attr_reader :block_trains

  NAME_FORMAT = /[a-z]/i.freeze

  def initialize(name)
    @name = name
    validate!
    @trains = []
    @all_stations ||= []
    @all_stations.push(self)
    register_instance
  end

  def self.all
    @all_stations
  end

  def reception_trains(train)
    @trains.push(train)
  end

  def puts_trains(train)
    @trains.delete(train)
  end

  def print_list_trains
    @list_trains = {}
    i = 0
    @trains.each do |train|
      i += 1
      @list_trains[i] = train.name
    end
    @list_trains
  end

  def trains_of_type(type)
    sum_trains = 0
    @trains.each do |train|
      sum_trains += 1 if train.type == type
    end
    sum_trains
  end

  def valid?
    validate!
    true
  rescue StandardError
    false
  end

  def show_trains(&block)
    @trains.each(&block)
  end

  protected

  def validate!
    raise 'Имя станции не может быть короче трех символов!' if @name.length < 3
    raise 'Имя станции не должно содержать ничего кроме букв!' if @name !~ NAME_FORMAT
  end
end
