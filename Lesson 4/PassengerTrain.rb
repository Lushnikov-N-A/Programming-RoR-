class PassengerTrain < Train

private #Нет подклассов, метод не вызывается кроме как в самом объекте.
  def type
    @type = "Passenger"
  end

end
