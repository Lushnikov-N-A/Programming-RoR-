class PassengerVagon < Vagon
  attr_accessor :type
  attr_accessor :number

  def initialize(seats)
    @type = "Passenger"
    @total_place = seats
    @number = 0
    @used_place = 0
  end
end
