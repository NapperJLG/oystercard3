class Journey
  attr_reader :entry_station, :exit_station, :journey
  MINIMUM_FARE = 2
  PENALTY_FARE = 6


  def initialize 
    @entry_station = ''
    @exit_station = ''
    @journey = {}
  
  end 

  def start(station)
    @entry_station = station
    @journey = {entry_station: entry_station}
  end

  def end(station)
    @exit_station = station
    @journey[:exit_station] = exit_station
  end 

  def fare
    complete? ? MINIMUM_FARE : PENALTY_FARE
  end 

  def complete?
    !(entry_station.empty? || exit_station.empty?)
  end 

end