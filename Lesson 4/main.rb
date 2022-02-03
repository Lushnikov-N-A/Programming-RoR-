
require_relative 'train'
require_relative 'station'
require_relative 'route'
require_relative 'CargoVagons'
require_relative 'PassengerVagons'
require_relative 'CargoTrain'
require_relative 'PassengerTrain'
#require_relative 'seed'

@arr_station = []
@arr_train = []
@arr_route = []
@name_for_search
@arr_vagon = []

def station_create
  puts "Введите название станции:"
  name = gets.chomp.to_s
  st = Station.new (name)
  @arr_station.push(st)
  puts ""
  puts "Новая станция #{st.name} создана."
  puts ""
end

def train_create(type)
  puts "Введите название поезда:"
  name = gets.chomp.to_s
  tr = Train.new(name)
  @type = type
  tr.type = @type
  @arr_train.push(tr)
  puts ""
  puts "Новый поезд #{tr.name} создан."
  puts ""
end

def route_create
  puts "Введите название первой станции маршрута:"
  name = gets.chomp.to_s
  st_first = Station.new(name)
  puts "Введите название конечной станции маршрута:"
  name = gets.chomp.to_s
  st_last = Station.new(name)
  puts "Введите название маршрута:"
  name = gets.chomp.to_s
  rt = Route.new(st_first, st_last)
  rt.name_route(name)
  @arr_route.push(rt)
end

def search_obj (obj) #Метод поиска объекта по имени в массиве объектов
  i = 0
  obj.each_with_index do |name, index|
    if name.name == @name_for_search
      i = index
    end
  end
  i
end

def put_station_route
  puts "Введите имя станции для добавления в маршрут:"
  @name_for_search = gets.chomp.to_s
  station = search_obj(@arr_station)
  puts "Введите имя маршрута для редактирования:"
  @name_for_search = gets.chomp.to_s
  route = search_obj(@arr_route)
  @arr_route[route].pushning_intermediate_stations(@arr_station[station])
  puts "В маршрут #{@arr_route[route].name} добавлена станция #{@arr_station[station].name}"
  @arr_route[route].print_list_station
end

def delete_station_route
  puts "Введите имя станции для удаления с маршрута:"
  @name_for_search = gets.chomp.to_s
  station = search_obj(@arr_station)
  puts "Введите имя маршрута для редактирования:"
  @name_for_search = gets.chomp.to_s
  route = search_obj(@arr_route)
  @arr_route[route].deleting_intermediate_stations(@arr_station[station])
  puts "В маршруте #{@arr_route[route].name} удалена станция #{@arr_station[station].name}"
  @arr_route[route].print_list_station
end

def put_route_train
  puts "Введите имя поезда для назначения маршрута:"
  @name_for_search = gets.chomp.to_s
  train = search_obj(@arr_train)
  puts "Введите имя маршрута для назначения поезду:"
  @name_for_search = gets.chomp.to_s
  route = search_obj(@arr_route)
  @name_for_search = @arr_route[route].stations[0].name.to_s
  station = search_obj(@arr_station)
  @arr_train[train].put_route(@arr_route[route])
  puts "Маршрут #{@arr_route[route].name} назначен поезду #{@arr_train[train].name}"
  @arr_station[station].reception_trains(@arr_train[train])
end

def put_vagon_train
  puts "Введите имя поезда для добавления вагона:"
  @name_for_search = gets.chomp.to_s
  train = search_obj(@arr_train)
  if @arr_train[train].type == "Cargo"
    vagon = CargoVagons.new
  else
    vagon = PassengerVagons.new
  end
  @arr_train[train].push_vagon(vagon)
  puts "Вагон добавлен к поезду #{@arr_train[train].name}"
  #puts   @arr_train[train].show_current_vagons
end

def delete_vagon_train
  puts "Введите имя поезда для удаление вагона:"
  @name_for_search = gets.chomp.to_s
  train = search_obj(@arr_train)
  @arr_train[train].delete_vagon
end

loop do
  puts "Введите номер действия:"
  puts "1. Создать новую  станцию."
  puts "2. Создать новый поезд."
  puts "3. Создать новый маршрут."
  puts "4. Редактировать маршрут."
  puts "5. Назначить маршрут поезду."
  puts "6. Изменить количество вагонов поезда."
  puts "7. Движение поезда"
  puts "8. Информация по маршруту поезда."
  puts "9. Информация по поездам на станции."
  puts "10. Выход."
  choice = gets.chomp.to_i

  case choice
  when 10
    break
  when 1
    station_create
  when 2
    loop do
      puts "Введите тип поезда:"
      puts "1. Грузовой."
      puts "2. Пассажирский."
      puts "3. Выход."
      choice = gets.chomp.to_i

        case choice
        when 3
          break
        when 1
          type = "Cargo"
          train_create(type)
        when 2
          type = "Passenger"
          train_create(type)
        end
    end

  when 3
    route_create
  when 4
    loop do
      puts "Введите номер действия:"
      puts "1. Добавить станцию в маршрут."
      puts "2. Удалить станцию с маршрута."
      puts "3. Выход."
      choice = gets.chomp.to_i

        case choice
        when 3
          break
        when 1
          put_station_route
        when 2
          delete_station_route
        end
    end

  when 5
    put_route_train
  when 6
    puts "Что Вы хотите сделать, удалить или добавить вагон к поезду?"
    loop do
      puts "1. Добавить вагон."
      puts "2. Удалить вагон."
      puts "3. Выход."
      choice = gets.chomp.to_i
      case choice
      when 3
        break
      when 1
        put_vagon_train
      when 2
        delete_vagon_train
      end
    end

  when 7
    puts "Введите имя поезда для перемещения:"
    @name_for_search = gets.chomp.to_s
    train = search_obj(@arr_train)
    loop do
      puts "Куда переместить поезд?"
      puts "1. Вперед."
      puts "2. Назад."
      puts "3. Выход."
      choice = gets.chomp.to_i
        case choice
        when 3
          break
        when 1
          n="+"
          @arr_train[train].train_go(n)
        when 2
          n="-"
          @arr_train[train].train_go(n)
        end
      end

    when 8
      puts "Введите имя поезда для вывода информации о маршруте:"
      @name_for_search = gets.chomp.to_s
      train = search_obj(@arr_train)
      @arr_train[train].train_station

    when 9
      puts "Введите имя станции для вывода информации о поездах на станции:"
      @name_for_search = gets.chomp.to_s
      station = search_obj(@arr_station)
      puts station
      puts @arr_station[station].name
      @arr_station[station].print_list_trains
  end

end
