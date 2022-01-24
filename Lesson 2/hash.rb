month_in_year = {

	January: 31,
	February: 28,
	March: 31,
	April: 30,
	May: 31,
	June: 30,
	July: 31,
	August: 31,
	September: 30,
	October: 31,
	November: 30,
	December:31
}

month_in_year.each do  |month,days|
	if month_in_year[month] == 30 
	  	puts "#{month}"
	end
end
