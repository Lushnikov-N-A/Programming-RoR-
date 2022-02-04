class Station
  attr_accessor :trains
  attr_accessor :name
  attr_accessor :reception_trains
  def initialize (name)
    @name = name
    @trains = []
  end
#Все методы Public, т.к. вызываются "из другого объекта".
  def reception_trains(train)
    @trains.push(train)
  end
  def puts_trains(train)
    @trains.delete(train)
  end
  def print_list_trains
    puts "На станции #{self.name} находятся поезда:"
    @trains.each_with_index do |train, index|
      puts "Поезд #{(index +1)} #{train.name}"
    end
  end
  def trains_of_type (type)
    i=0
    puts "Список поездов по типу #{type}:"
    @trains.each_with_index do |train, index|
      if train.type == type
        i+=1
        puts " Поезд #{(index +1)} #{train.name}"
      end
    end
    puts "Количество поездов #{type} = #{i}"
  end
end
