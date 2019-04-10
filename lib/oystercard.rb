class Oystercard
  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1
  MINIMUM_FARE = 2

attr_reader :balance, :entry_station, :journeys, :journey
  def initialize
    @balance = 0
    @journeys = []
  end

  def top_up(value)
    raise "maximum balance of #{MAXIMUM_BALANCE} exceeded" if (@balance + value) > MAXIMUM_BALANCE
    @balance += value
  end

  def in_journey?
    !!@entry_station
  end

  def touch_in(entry_station)
    raise "Insuficient funds" if @balance < MINIMUM_BALANCE
    @entry_station = entry_station
    @journey = {entry_station: entry_station}
  end

  def touch_out(exit_station)
    deduct(MINIMUM_FARE)
    @journey[:exit_station] = exit_station
    @entry_station = nil
    update_journeys
  end

  private

  def deduct(value)
  	@balance -= value
  end

  def update_journeys
    @journeys << @journey
  end

end
