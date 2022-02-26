# frozen_string_literal: true

class PassengerVagon < Vagon
  attr_accessor :type, :number
  attr_reader :total_place, :free_place, :used_place

  def initialize(volume)
    @type = 'Passenger'
    super
  end

  def filling
    @vol ||= 1 # переменная нужна для работы метода валидации
    validate!
    @used_place += 1
    @free_place = @total_place - @used_place
  end
end
