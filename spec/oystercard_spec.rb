require 'oystercard'

describe Oystercard do

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

  describe "#deduct" do
    it "deducts fare from card" do
      subject.top_up(30)
      subject.deduct(5)
      expect(subject.balance).to eq 25
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
      expect{oyster.touch_in}.to change {oyster.in_journey?}.from(false).to(true)
    end

    it "raise an error if balance below minimum balance" do
      expect{ subject.touch_in }.to raise_error("Insuficient funds")
    end
  end

  describe "#touch_out" do
    it "sets in_journey to false" do
      oyster.top_up(5)
      oyster.touch_in
      expect{oyster.touch_out}.to change {oyster.in_journey?}.from(true).to(false)
    end
  end
end
