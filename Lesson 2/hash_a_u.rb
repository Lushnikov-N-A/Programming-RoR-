array_letter = ('a'..'z').to_a
hash_letter = Hash.new

array_letter.each do |item| 
case
when item == "a" 	
	hash_letter[item.to_sym] = (1+array_letter.find_index("a"))
when item == "e" 	
	hash_letter[item.to_sym] = (1+array_letter.find_index("e"))
when item == "i" 	
	hash_letter[item.to_sym] = (1+array_letter.find_index("i"))
when item == "o" 	
	hash_letter[item.to_sym] = (1+array_letter.find_index("o"))
when item == "u" 	
	hash_letter[item.to_sym] = (1+array_letter.find_index("u"))
when item == "y" 	
	hash_letter[item.to_sym] = (1+array_letter.find_index("y"))
end
end
puts hash_letter 