require_relative 'manufacturer'
require_relative 'instance_counter'
require_relative 'train'
require_relative 'station'
require_relative 'route'
require_relative 'vagon'
require_relative 'cargo_vagon'
require_relative 'passenger_vagon'
require_relative 'cargo_train'
require_relative 'passenger_train'

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
  begin
    puts "Введите название поезда:"
    name = gets.chomp.to_s
    puts "Введите номер поезда:"
    number = gets.chomp.to_s
    tr = Train.new(name, number)
    tr.valid?
  rescue
    puts "Повторите ввод данных!"
    retry
  end
  @type = type
  tr.type = @type
  @trains.push(tr)
  puts "Новый поезд #{tr.name} создан."
end

def route_create
  puts "Введите название первой станции маршрута:"
  @name_for_search = gets.chomp.to_s
  st_first = @stations[search_obj(@stations)]
  puts "Введите название конечной станции маршрута:"
  @name_for_search = gets.chomp.to_s
  st_last = @stations[search_obj(@stations)]
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
  @routes[route].pushning_intermediate_stations(@stations[station])
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
  @routes[route].deleting_intermediate_stations(@stations[station])
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
    puts "Введите объем вагона:"
    vol = gets.chomp.to_i
    vagon = CargoVagon.new(vol)
  else
    puts "Введите количество мест в вагоне:"
    vol = gets.chomp.to_i
    vagon = PassengerVagon.new(vol)
    vagon.number += 1
  end
  @trains[train].push_vagon(vagon)
  vagon.number = @trains[train].vagons.length
  puts "Вагон добавлен к поезду #{@trains[train].name}"
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
  puts (@trains[train].stations_information)
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

def filling_vagon
  puts "Введите имя поезда для выбора вагона:"
  @name_for_search = gets.chomp.to_s
  train = search_obj(@trains)
  puts "Введите номер вагона для заполнения:"
  num = gets.chomp.to_i - 1
  if @trains[train].type == "Cargo"
    puts "Введите объем для загрузки вагона:"
    vol = gets.chomp.to_i
    @trains[train].vagons[num].filling(vol)
    puts "Объем #{vol} загружен."
  else
    @trains[train].vagons[num].filling(1)
    puts "Посадка пассажира выполнена."
  end
end

def train_on_station
  puts "Введите имя станции для вывода информации о поездах на станции:"
  @name_for_search = gets.chomp.to_s
  station = search_obj(@stations)
  block = proc { |each_train| puts "Поезд #{each_train.name} № #{each_train.number}, тип: #{each_train.type}, количество вагонов #{each_train.show_current_vagons}"}
  puts "На станции #{@stations[station].name} находятся поезда:"
  @stations[station].show_trains(&block)
end

def vagons_train_information
  puts "Введите имя поезда для вывода информации:"
  @name_for_search = gets.chomp.to_s
  train = search_obj(@trains)
  if @trains[train].type == "Cargo"
    block = proc { |each_train| puts "Вагон № #{each_train.number}, тип: #{each_train.type}, занятый объем #{each_train.show_filling_vol}, свободный объем #{each_train.show_free_vol}"}
  else
    block = proc { |each_train| puts "Вагон № #{each_train.number}, тип: #{each_train.type}, занятые места #{each_train.show_filling_vol}, свободные места #{each_train.show_free_vol}"}
  end
  puts "Список вагонов поезда #{@trains[train].name}:"
  @trains[train].all_vagons(&block)
end

loop do
  puts "Введите номер действия:"
  puts "1. Создать новую  станцию."
  puts "2. Создать новый поезд."
  puts "3. Создать новый маршрут."
  puts "4. Редактировать маршрут."
  puts "5. Назначить маршрут поезду."
  puts "6. Изменить количество вагонов поезда."
  puts "7. Заполнение вагона."
  puts "8. Движение поезда."
  puts "9. Информация по маршруту поезда."
  puts "10. Информация по поездам на станции."
  puts "11. Вывести информацию о вагонах поезда."
  puts "12. Выход."
  choice = gets.chomp.to_i
  case choice
  when 12
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
    filling_vagon
  when 8
    move_train
  when 9
    information_route
  when 10
    train_on_station
  when 11
    vagons_train_information
  end
end
