puts "Введите коэффициент A:"
a = gets.to_f
puts "Введите коэффициент B:"
b = gets.to_f
puts "Введите коэффициент C:"
c = gets.to_f
d = ((b**2) - (4*a*c))

case
  when d<0
  	puts "Корней нет"
  when d==0
  	puts "Дискримант D = #{d}, корень X = #{(-b/(2*a))}"
  when d>0
  	puts "Дискримант D = #{d}, корень X1 = #{((-b + Math.sqrt(d))/(2*a))}, корень X2 = #{((-b - Math.sqrt(d))/(2*a))}."
end