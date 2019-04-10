require 'journey'

describe Journey do 

    context "Initialize journey" do
      it 'set entry_station to be empty' do
        expect(subject.entry_station).to eq ''
      end

      it 'set exit_station to be empty' do
        expect(subject.exit_station).to eq ''
      end
    end 


  describe '#start' do 
    it "save the entry station" do
      subject.start("kingscross")
      expect(subject.entry_station).to eq "kingscross" 
    end 
  end 

  describe '#end' do 
    it "save the exit station" do
      subject.end("aldgate")
      expect(subject.exit_station).to eq "aldgate" 
    end 
  end 

  describe '#fare' do
    it "return the fare if the journey is complete" do
      allow(subject).to receive(:complete?).and_return(true)
      expect(subject.fare).to eq Journey::MINIMUM_FARE
    end 

    it "charge the penalty if the journey is not complete" do 
      allow(subject).to receive(:complete?).and_return(false)
      expect(subject.fare).to eq Journey::PENALTY_FARE
    end 


  end 

  describe"complete?" do
    it 'return false when no entry_station info' do
      subject.end("aldgate")
      expect(subject.complete?).to eq false
    end

    it 'return false when no exit_station info' do
      subject.start('kingscross')
      expect(subject.complete?).to eq false
    end

    it 'return true when there are both entry_station and exit_station' do
      subject.start('kingscross')
      subject.end("aldgate")
      expect(subject.complete?).to eq true
    end 

  end 

end 