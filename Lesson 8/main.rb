# frozen_string_literal: true

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
  puts 'Введите название станции:'
  name = gets.chomp.to_s
  st = Station.new(name)
  @stations.push(st)
end

def search_station(name)
  @stations.detect { |station| station.name == name }
end

def search_route(name)
  @routes.detect { |route| route.name == name }
end

def search_train(name)
  @trains.detect { |train| train.name == name }
end

def name_train
  puts 'Введите название поезда:'
  @name_train = gets.chomp.to_s
  puts 'Введите номер поезда:'
  @number_train = gets.chomp.to_s
end

def train_create(type)
  begin
    name_train
    tr = Train.new(@name_train, @number_train)
    tr.valid?
  rescue StandardError
    puts 'Повторите ввод данных!'
    retry
  end
  tr.type = type
  @trains.push(tr)
end

def station_to_route
  puts 'Введите название первой станции маршрута:'
  @st_first = search_station(gets.chomp.to_s)
  puts 'Введите название конечной станции маршрута:'
  @st_last = search_station(gets.chomp.to_s)
end

def route_create
  station_to_route
  rt = Route.new(@st_first, @st_last)
  puts 'Введите название маршрута:'
  rt.name_route(gets.chomp.to_s)
  @routes.push(rt)
end

def put_station_route
  puts 'Введите имя станции для добавления в маршрут:'
  station_name = gets.chomp.to_s
  puts 'Введите имя маршрута для редактирования:'
  route_name = gets.chomp.to_s
  search_route(route_name).ins_stations(search_station(station_name))
end

def delete_station_route
  puts 'Введите имя станции для удаления с маршрута:'
  station_name = gets.chomp.to_s
  puts 'Введите имя маршрута для редактирования:'
  route_name = gets.chomp.to_s
  search_route(route_name).del_stations(search_station(station_name))
  puts "В маршруте #{search_route(route_name).name} удалена станция #{search_station(station_name).name}"
end

def put_route_train
  puts 'Введите имя поезда для назначения маршрута:'
  train_name = gets.chomp.to_s
  puts 'Введите имя маршрута для назначения поезду:'
  route_name = gets.chomp.to_s
  search_train(train_name).put_route(search_route(route_name))
  search_route(route_name).stations[0].reception_trains(search_train(train_name))
end

def add_vagon(*)
  search_train(@train_name).push_vagon(@vagon)
  @vagon.number = search_train(@train_name).vagons.length
  puts "Вагон добавлен к поезду #{search_train(@train_name).name}"
end

def add_cargo_vagon
  puts 'Введите объем вагона:'
  vol = gets.chomp.to_i
  @vagon = CargoVagon.new(vol)
end

def add_passenger_vagon
  puts 'Введите количество мест в вагоне:'
  vol = gets.chomp.to_i
  @vagon = PassengerVagon.new(vol)
end

def put_vagon_train
  puts 'Введите имя поезда для добавления вагона:'
  @train_name = gets.chomp.to_s
  if search_train(@train_name).type == 'Cargo'
    add_cargo_vagon
  else
    add_passenger_vagon
  end
  add_vagon(@vagon)
end

def delete_vagon_train
  puts 'Введите имя поезда для удаление вагона:'
  train_name = gets.chomp.to_s
  search_train(train_name).delete_vagon
end

def train_move_operation(operation_code)
  operations = Hash.new {}
  operations[1] = -> { search_train(@train_name).train_go('+') }
  operations[2] = -> { search_train(@train_name).train_go('-') }
  operations[operation_code].call
end

def move_train
  loop do
    puts 'Введите имя поезда для перемещения:'
    @train_name = gets.chomp.to_s
    puts '1. Вперед.'
    puts '2. Назад.'
    puts '3. Выход.'
    operation = gets.chomp.to_i
    break if operation == 3

    train_move_operation(operation)
  end
end

def information_route
  puts 'Введите имя поезда для вывода информации о маршруте:'
  train_name = gets.chomp.to_s
  puts search_train(train_name).stations_information
end

def type_train_operation(operation_code)
  operations = {}
  operations[1] = -> { train_create('Cargo') }
  operations[2] = -> { train_create('Passenger') }
  operations[operation_code].call
end

def create_train
  loop do
    puts 'Введите тип поезда:'
    puts '1. Грузовой.'
    puts '2. Пассажирский.'
    puts '3. Выход.'
    operation = gets.chomp.to_i
    break if operation == 3

    type_train_operation(operation)
  end
end

def route_operation(operation_code)
  operations = {}
  operations[1] = -> { put_station_route }
  operations[2] = -> { delete_station_route }
  operations[operation_code].call
end

def red_route
  loop do
    puts 'Введите номер действия:'
    puts '1. Добавить станцию в маршрут.'
    puts '2. Удалить станцию с маршрута.'
    puts '3. Выход.'
    operation = gets.chomp.to_i
    break if operation == 3

    route_operation(operation)
  end
end

def vagon_operation(operation_code)
  operations = {}
  operations[1] = -> { put_vagon_train }
  operations[2] = -> { delete_vagon_train }
  operations[operation_code].call
end

def change_vagons
  puts 'Что Вы хотите сделать, удалить или добавить вагон к поезду?'
  loop do
    puts '1. Добавить вагон.'
    puts '2. Удалить вагон.'
    puts '3. Выход.'
    operation = gets.chomp.to_i
    break if operation == 3

    vagon_operation(operation)
  end
end

def train_name_for_filing
  puts 'Введите имя поезда для выбора вагона или "Quit" для выхода:'
  @train_name = gets.chomp.to_s
end

def vagon_for_filling
  puts 'Введите номер вагона для заполнения:'
  @num = gets.chomp.to_i - 1
end

def vagon_filling
  if search_train(@train_name).type == 'Cargo'
    puts 'Введите объем для загрузки вагона:'
    vol = gets.chomp.to_i
    search_train(@train_name).vagons[@num].filling(vol)
    puts "Объем #{vol} загружен."
  else
    search_train(@train_name).vagons[@num].filling
  end
end

def vagon_errors_filing
  if search_train(@train_name).type == 'Cargo'
    puts "Измените вагон, свободный объем вагона № #{@num + 1} = #{search_train(@train_name).vagons[@num].free_place}"
  end
  puts "Измените вагон, свободных мест в вагоне № #{@num + 1} нет}" if search_train(@train_name).type == 'Passenger'
end

def filling_vagon
  loop do
    train_name_for_filing
    break if @train_name == 'Quit'

    vagon_for_filling
    vagon_filling
  rescue StandardError
    vagon_errors_filing
    retry
  end
end

def train_on_station
  puts 'Введите имя станции для вывода информации о поездах на станции:'
  station_name = gets.chomp.to_s
  block = proc { |each_train|
    puts "Поезд #{each_train.name} № #{each_train.number}, тип: #{each_train.type}, вагоны #{each_train.show_vagons}"
  }
  puts "На станции #{search_station(station_name).name} находятся поезда:"
  search_station(station_name).show_trains(&block)
end

def vagons_train_information
  block_search_train = proc { |vagon|
    puts "В № #{vagon.number}, Т: #{vagon.type}, З: #{vagon.used_place}, Д: #{vagon.free_place}"
  }
  puts 'Введите имя поезда для вывода информации:'
  @train_name = gets.chomp.to_s
  puts "Список вагонов поезда #{search_train(@train_name).name}:"
  search_train(@train_name).all_vagons(&block_search_train)
end

def choise_operation(operation)
  operations = {}
  operations[1] = -> { station_create }
  operations[2] = -> { create_train }
  operations[3] = -> { route_create }
  operations[4] = -> { red_route }
  operations[5] = -> { put_route_train }
  operations[6] = -> { change_vagons }
  operations[7] = -> { filling_vagon }
  operations[8] = -> { move_train }
  operations[9] = -> { information_route }
  operations[10] = -> { train_on_station }
  operations[11] = -> { vagons_train_information }
  operations[12] = -> { exit }
  operations[operation].call
end

loop do
  puts 'Введите номер действия:'
  puts '1. Создать новую  станцию.'
  puts '2. Создать новый поезд.'
  puts '3. Создать новый маршрут.'
  puts '4. Редактировать маршрут.'
  puts '5. Назначить маршрут поезду.'
  puts '6. Изменить количество вагонов поезда.'
  puts '7. Заполнение вагона.'
  puts '8. Движение поезда.'
  puts '9. Информация по маршруту поезда.'
  puts '10. Информация по поездам на станции.'
  puts '11. Вывести информацию о вагонах поезда.'
  puts '12. Выход.'
  choise_operation(gets.chomp.to_i)
end
