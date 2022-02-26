# frozen_string_literal: true

class Vagon
  include Manufacturer

  attr_reader :total_place, :used_place, :free_place

  def initialize(volume)
    @total_place = volume
    @free_place = volume
    @number = 0
    @used_place = 0
  end

  def filling(vol)
    @vol = vol
    validate!
    @used_place += vol
    @free_place = @total_place - @used_place
  end

  def validate!
    return unless @total_place < (@used_place + @vol)
    raise(puts(RuntimeError.new('Превышен объем вагона!'))) if type == 'Cargo'
    raise(puts(RuntimeError.new('Превышено количество мест вагона!'))) if type == 'Passenger'
  end
end
