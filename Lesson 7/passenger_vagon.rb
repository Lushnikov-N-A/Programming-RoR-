class PassengerVagon < Vagon

  attr_accessor :type
  attr_accessor :number
  attr_reader :total_place
  attr_reader :free_place
  attr_reader :used_place

  def initialize(seats)
    @type = "Passenger"
    @total_place = seats
    @free_place = seats
    @number = 0
    @used_place = 0
  end

  def filling
    @vol = 1 #переменная нужна для работы метода валидации
    validate!
    @used_place += 1
    @free_place = @total_place - @used_place
  end
end
