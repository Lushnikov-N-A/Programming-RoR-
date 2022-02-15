class CargoVagon < Vagon
  attr_accessor :type
  attr_accessor :volume
  attr_accessor :number
  attr_accessor :filling_vol
  attr_accessor :free_vol

  def initialize(volume)
    @type = "Cargo"
    @volume = volume
    @number = 0
    @filling_vol = 0
    @free_vol = 0
  end

  def filling(vol)
    self.filling_vol += vol
  end

  def show_filling_vol
    @filling_vol
  end

  def show_free_vol
    @free_vol = self.volume - @filling_vol
  end
end
