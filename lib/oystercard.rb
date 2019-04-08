class Oystercard

attr_reader :balance
def initialize
  @balance = 0
end

def top_up(value)
  raise "maximum balance exceeded" if (@balance += value) > 90
end

end
