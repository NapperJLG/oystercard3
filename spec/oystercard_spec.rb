require 'oystercard'

describe Oystercard do
  let(:station) {double :station}
  it "checks new card has a balance of 0" do
    expect(subject.balance).to eq 0
  end

  describe '#top_up' do
    it 'tops up balance of the card by a specified amount' do
      subject.top_up(30)
      expect(subject.balance).to eq 30
    end

    it "Raises an error if balance exceeds £90" do
      subject.top_up(Oystercard::MAXIMUM_BALANCE)
      expect { subject.top_up(1) }.to raise_error("maximum balance of #{Oystercard::MAXIMUM_BALANCE} exceeded")
    end
  end

  describe "#in_journey?" do
    it 'when new card is created, it is not in journey' do
      expect(subject).not_to be_in_journey
    end
  end

  let (:oyster) {subject}

  describe "#touch_in" do
    it "sets in_journey to true" do
      oyster.top_up(5)
      oyster.touch_in(station)
      expect(oyster).to be_in_journey
    end

    it "raise an error if balance below minimum balance" do
      expect{ subject.touch_in(station) }.to raise_error("Insuficient funds")
    end

    it "records the entry station for the current journey" do
      oyster.top_up(5)
      subject.touch_in(station)
      expect(subject.entry_station).to eq station
    end
  end

  describe "#touch_out" do
    it "sets in_journey to false" do
      oyster.top_up(5)
      oyster.touch_in(station)
      oyster.touch_out
      expect(oyster).not_to be_in_journey
    end
    
    it "reduces the balance by the minimum fare" do
      oyster.top_up(5)
      oyster.touch_in(station)
      expect{oyster.touch_out}.to change {oyster.balance }.by (-Oystercard::MINIMUM_FARE)
    end

    it "forgets entry station" do
      oyster.top_up(5)
      oyster.touch_in(station)
      expect{oyster.touch_out}.to change {oyster.entry_station}.from(station).to(nil)
    end
  end
end
