
cart = {}
sum, product, cost, quantity = 0.0
while ((product != "стоп") || (cost != "стоп") || (quantity != "стоп")) do
	puts "Введите название товара"
	product = gets.chomp.to_str
		if product == "стоп"
			then break
		end
	puts "Введите цену за еденицу товару"
	cost = gets.chomp.to_f
		if cost.to_s == "стоп"
			then break
		end
	puts "Введите количество товара"
	quantity = gets.chomp.to_f
		if quantity.to_s == "стоп"
			then break
		end
	cart[product] = {cost => quantity}
end

puts "Корзина: #{cart}"

cart.each do |product, cost|
	puts "Цена товара #{product} = #{cost.keys.first * cost.values.first}"
	sum += (cost.keys.first * cost.values.first).to_f
end
 puts "Сумма покупок = #{sum}"