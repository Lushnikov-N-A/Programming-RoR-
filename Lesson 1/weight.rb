puts "Привет! Как Вас зовут?"
name = gets.chomp
puts "Какой у Вас рост, см?"
height = gets.to_i
calculation_weight = (height - 110)*1.15
if calculation_weight <= 0
	puts "#{name}, Ваш вес уже оптимален!"
else 
	puts "#{name}, Ваш идеальный вес = #{calculation_weight} кг!"
end