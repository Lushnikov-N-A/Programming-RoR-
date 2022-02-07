class PassengerVagon < Vagon
  attr_accessor :type

  def initialize
    @type = "Passenger"
  end
end
