days_in_month = [31,28,31,30,31,30,31,31,30,31,30,31]
leap_year = false
order_number = 0
i = 0

puts "Введите число:"
day = gets.to_i

puts "Введите месяц:"
month = gets.to_i

puts "Введите год:"
year = gets.to_i

if (year % 4 == 0) && (year % 100 != 0)
	puts "Год #{year} високосный"
	leap_year = true
elsif (year % 4 == 0) && (year % 100 == 0) && (year % 400 == 0)
	puts "Год #{year} високосный"
	leap_year = true
else
	puts "Год #{year} не високосный"
	leap_year = false
end

case
when leap_year == true
	if month == 1 
		order_number = day
		puts "Порядковый номер даты в году: #{order_number}"
	elsif month == 2
		order_number = days_in_month[0] + day
		puts "Порядковый номер даты в году: #{order_number}"
	elsif month > 2
		loop do
			order_number += days_in_month[i]
			i +=1
			break if i == month-1
		end
		puts "Порядковый номер даты в году: #{order_number + day +1}"	
	end
when leap_year == false	
	if month == 1 
		order_number = day
		puts "Порядковый номер даты в году: #{order_number}"
	elsif month == 2
		order_number = days_in_month[0] + day
		puts "Порядковый номер даты в году: #{order_number}"
	elsif month > 2
		loop do
			order_number += days_in_month[i]
			i +=1
			break if i == month-1
		end
		puts "Порядковый номер даты в году: #{order_number + day}"	
	end
end



