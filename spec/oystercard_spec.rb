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
      subject.top_up(90)
    expect { subject.top_up(1) }.to raise_error("maximum balance exceeded")
  end
  end
end
