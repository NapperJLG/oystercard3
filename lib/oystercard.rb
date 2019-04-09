class Oystercard
  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1
  MINIMUM_FARE = 2

attr_reader :balance, :entry_station
  def initialize
    @balance = 0
  end

  def top_up(value)
    raise "maximum balance of #{MAXIMUM_BALANCE} exceeded" if (@balance + value) > MAXIMUM_BALANCE
    @balance += value
  end

  def in_journey?
    !!@entry_station
  end

  def touch_in(station)
    raise "Insuficient funds" if @balance < MINIMUM_BALANCE
    @entry_station = station
  end

  def touch_out
    deduct(MINIMUM_FARE)
    @entry_station = nil
  end

  private

  def deduct(value)
  	@balance -= value
  end

end
