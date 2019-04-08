require 'oystercard'

describe Oystercard do
  it "creates new oystercard" do
    card = Oystercard.new
    expect(card).to be_a Oystercard
  end
end
