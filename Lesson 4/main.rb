
require_relative 'train'
require_relative 'station'
require_relative 'route'
require_relative 'vagon'
require_relative 'cargo_vagon'
require_relative 'passenger_vagon'
require_relative 'cargo_train'
require_relative 'passenger_train'

#require_relative 'seed'
@stations = []
@trains = []
@routes = []
@vagons = []
def station_create
  puts "Введите название станции:"
  name = gets.chomp.to_s
  st = Station.new (name)
  @stations.push(st)
  puts "Новая станция #{st.name} создана."
end
def train_create(type)
  puts "Введите название поезда:"
  name = gets.chomp.to_s
  tr = Train.new(name)
  @type = type
  tr.type = @type
  @trains.push(tr)
  puts "Новый поезд #{tr.name} создан."
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
  @routes.push(rt)
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
  station = search_obj(@stations)
  puts "Введите имя маршрута для редактирования:"
  @name_for_search = gets.chomp.to_s
  route = search_obj(@routes)
  @routes[route].pushning_intermediate_(@stations[station])
  puts "В маршрут #{@routes[route].name} добавлена станция #{@stations[station].name}"
  @routes[route].print_list_station
end
def delete_station_route
  puts "Введите имя станции для удаления с маршрута:"
  @name_for_search = gets.chomp.to_s
  station = search_obj(@stations)
  puts "Введите имя маршрута для редактирования:"
  @name_for_search = gets.chomp.to_s
  route = search_obj(@routes)
  @routes[route].deleting_intermediate_(@stations[station])
  puts "В маршруте #{@routes[route].name} удалена станция #{@stations[station].name}"
  @routes[route].print_list_station
end
def put_route_train
  puts "Введите имя поезда для назначения маршрута:"
  @name_for_search = gets.chomp.to_s
  train = search_obj(@trains)
  puts "Введите имя маршрута для назначения поезду:"
  @name_for_search = gets.chomp.to_s
  route = search_obj(@routes)
  @name_for_search = @routes[route].stations[0].name.to_s
  station = search_obj(@stations)
  @trains[train].put_route(@routes[route])
  puts "Маршрут #{@routes[route].name} назначен поезду #{@trains[train].name}"
  @stations[station].reception_trains(@trains[train])
end
def put_vagon_train
  puts "Введите имя поезда для добавления вагона:"
  @name_for_search = gets.chomp.to_s
  train = search_obj(@trains)
  if @trains[train].type == "Cargo"
    vagon = CargoVagons.new
  else
    vagon = PassengerVagons.new
  end
  @trains[train].push_vagon(vagon)
  puts "Вагон добавлен к поезду #{@trains[train].name}"
  #puts   @trains[train].show_current_vagons
end
def delete_vagon_train
  puts "Введите имя поезда для удаление вагона:"
  @name_for_search = gets.chomp.to_s
  train = search_obj(@trains)
  @trains[train].delete_vagon
end
def move_train
  puts "Введите имя поезда для перемещения:"
  @name_for_search = gets.chomp.to_s
  train = search_obj(@trains)
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
      @trains[train].train_go(n)
    when 2
      n="-"
      @trains[train].train_go(n)
    end
  end
end
def information_route
  puts "Введите имя поезда для вывода информации о маршруте:"
  @name_for_search = gets.chomp.to_s
  train = search_obj(@trains)
  @trains[train].train_station
end
def information_trains_station
  puts "Введите имя станции для вывода информации о поездах на станции:"
  @name_for_search = gets.chomp.to_s
  station = search_obj(@stations)
  puts station
  puts @stations[station].name
  @stations[station].print_list_trains
end
def create_train
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
end
def red_route
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
end
def change_vagons
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
    create_train
  when 3
    route_create
  when 4
    red_route
  when 5
    put_route_train
  when 6
    change_vagons
  when 7
    move_train
  when 8
    information_route
  when 9
    information_trains_station
  end
end
