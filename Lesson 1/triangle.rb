puts "Введите длину первой стороны треугольника:"
a = gets.to_f
puts "Введите длину второй стороны треугольника:"
b = gets.to_f
puts "Введите длину третьей стороны треугольника:"
c = gets.to_f

if (a==b && b==c)
	puts "Треугольник является равносторонним и равнобедренным."
end

if (a==b || a==c || b==c)
	puts "Треугольник является равнобедренным."
end

if (a>b) && (a>b) && ((a**2) == (b**2) + (c**2))
	puts "Треугольник является прямоугольным."
end

if (b>a) && (b>c) && ((b**2)==(a**2) + (c**2))
	puts "Треугольник является прямоугольным."
end

if (c>a) && (c>b) && ((c**2)==(a**2) + (b**2))
	puts "Треугольник является прямоугольным."
end