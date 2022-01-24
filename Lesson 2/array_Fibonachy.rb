array_fibonachy = []
array_fibonachy[0] = 0
array_fibonachy[1] = 1
k = 2
f = 1
 
while f < 100 do
	f1 = array_fibonachy[k-2]
	f2 = array_fibonachy[k-1]
	f = f1+f2

	if f >= 100
		then break
	end
	
	array_fibonachy[k] = f
	k +=1
end

puts "Ряд Фибоначчи до 100:"
puts "#{array_fibonachy} "


