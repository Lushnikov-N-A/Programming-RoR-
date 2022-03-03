# frozen_string_literal: true

class CargoVagon < Vagon
  attr_accessor :number
  attr_reader :type

  def initialize(volume)
    @type = 'Cargo'
    super
  end
end
