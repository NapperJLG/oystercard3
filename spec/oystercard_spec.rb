require 'oystercard'

describe Oystercard do
  it "checks new card has a balance of 0" do
    card = Oystercard.new
    expect(subject.balance).to eq 0
  end
end
