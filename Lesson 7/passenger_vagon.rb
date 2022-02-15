class PassengerVagon < Vagon
  attr_accessor :type
  attr_accessor :seats
  attr_accessor :number
  attr_accessor :filling_vol
  attr_accessor :free_vol

  def initialize(seats)
    @type = "Passenger"
    @seats = seats
    @number = 0
  end

  @filling_vol = 0
  @free_vol = 0

  def filling(vol)
    @filling_vol += vol
  end

  def show_filling_vol
    @filling_vol
  end

  def show_free_vol
    @free_vol = self.volume - @filling_vol
  end
end
