class Vagon
  include Manufacturer

  attr_reader :total_place
  attr_reader :used_place
  attr_reader :free_place

  def filling(vol)
    @vol = vol
    validate!
    @used_place += vol
    @free_place = @total_place - @used_place
  end

  def validate!
    if @total_place < @used_place + @vol
      if self.type == "Cargo"
        raise puts RuntimeError.new("Превышен объем вагона!")
      else
        raise puts RuntimeError.new("Превышено количество мест вагона!")
      end
    end
  end
end
