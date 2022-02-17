class Station
  include InstanceCounter
  attr_accessor :trains
  attr_accessor :name
  attr_accessor :reception_trains
  attr_accessor :list_trains
  attr_reader :block_trains
  attr_accessor :show_trains
  attr_reader :all_stations

  NAME_FORMAT = /[a-z]/i

  $all_stations = []

  def self.all
    all_stations
  end

  def initialize (name)
    @name = name
    validate!
    @trains = []
    $all_stations.push(self)
    register_instance
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
    @trains.each_with_index do |train|
      i+=1
      @list_trains[i] = train.name
    end
    @list_trains
  end

  def trains_of_type (type)
    sum_trains = 0
      @trains.each_with_index do |train|
      if train.type == type
        sum_trains += 1
      end
    end
    sum_trains
  end

  def valid?
    validate!
    true
    rescue
      false
  end

  def show_trains(&block)
    @trains.each {|each_train| yield(each_train)}
  end

  protected

  def validate!
    raise "Имя станции не может быть короче трех символов!" if @name.length < 3
    raise "Имя станции не должно содержать ничего кроме букв!" if @name !~ NAME_FORMAT
  end
end
