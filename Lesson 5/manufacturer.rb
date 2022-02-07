module Manufacturer

  def reception_manufacturer
    puts "Введите название производителя:"
    @manufacturer = gets.chomp.to_s
  end

  def send_manufacturer
    @manufacturer
  end
end
