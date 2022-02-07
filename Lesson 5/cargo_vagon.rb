class CargoVagon < Vagon
  attr_accessor :type
  #Нет подклассов, метод не вызывается кроме как в самом объекте.

  def initialize
    @type = "Cargo"
  end
end
