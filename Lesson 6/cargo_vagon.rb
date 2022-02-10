class CargoVagon < Vagon
  attr_accessor :type

  def initialize
    @type = "Cargo"
  end
end
