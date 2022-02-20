class CargoVagon < Vagon

  attr_accessor :type
  attr_accessor :number

  def initialize(volume)
    @type = "Cargo"
    @total_place = volume
    @free_place = volume
    @number = 0
    @used_place = 0
  end
end
