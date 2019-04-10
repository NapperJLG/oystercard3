require 'oystercard'

describe Oystercard do
  let(:station) {double :station}
  let (:oyster) {subject}
  # let(:entry_station) {double :entry_station}

  context "initialize the oystercard" do
    it "checks new card has a balance of 0" do
      expect(subject.balance).to eq 0
    end

    it "the journeys is empty for a new card" do
      expect(subject.journeys).to eq []
    end
  end 


  describe '#top_up' do
    it 'tops up balance of the card by a specified amount' do
      subject.top_up(30)
      expect(subject.balance).to eq 30
    end

    it "Raises an error if balance exceeds £90" do
      subject.top_up(Oystercard::MAXIMUM_BALANCE)
      expect { subject.top_up(1) }.to raise_error("maximum balance of #{ Oystercard::MAXIMUM_BALANCE } exceeded" )
    end
  end

  # describe "#in_journey?" do
  #   it 'when new card is created, it is not in journey' do
  #     expect(subject).not_to be_in_journey
  #   end
  # end

  context "Unusd new card" do
    describe "#touch_in" do
      it "raise an error if balance below minimum balance" do
        expect{ subject.touch_in(station) }.to raise_error( "Insuficient funds" )
      end
  end 
end

  context "touch in and out" do 
    before :each do
      oyster.top_up(5)
      oyster.touch_in(station)
    end 

    describe "#touch_in" do
      # it "sets in_journey to true" do
      #   expect(oyster).to be_in_journey
      # end

      it "records the entry station for the current journey" do
        expect(subject.touch_in(station)).to eq({entry_station: station})
      end
    end

    describe "#touch_out" do
      # it "sets in_journey to false" do
      #   oyster.touch_out(station)
      #   expect(oyster).not_to be_in_journey
      # end
    
      it "reduces the balance by the minimum fare" do
        stub_const('Oystercard::MINIMUM_FARE', 3)
        expect{ oyster.touch_out(station) }.to change {oyster.balance }.by(-Oystercard::MINIMUM_FARE)
      end

      it "record the exit station" do 
        oyster.touch_in("aldgate")
        @journey = {entry_station: "aldgate"}
        oyster.touch_out("kingscross")
        expect(oyster.journeys).to eq [{
        entry_station: "aldgate",
        exit_station: "kingscross"
        }]
      end

      # it "forgets entry station" do
      #   oyster.top_up(5)
      #   oyster.touch_in(station)
      #   expect{ oyster.touch_out(station) }.to change { oyster.entry_station }.from( station ).to( nil )
      # end
    end 

  end
end
