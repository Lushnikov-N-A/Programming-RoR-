class Vagon
  include Manufacturer
  attr_accessor :total_place
  attr_accessor :used_place
  attr_accessor :free_place

  def filling(vol)
      @used_place += vol
  end

  def show_filling_vol
    @used_place
  end

  def show_free_vol
    @free_place = self.total_place - @used_place
  end
end
