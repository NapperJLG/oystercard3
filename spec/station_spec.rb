require 'station'

describe Station do
  it "initialize the station name" do
    station = Station.new("kingscross", 1)
    expect(station.name).to eq "kingscross"
  end

  it "initialize the station zone" do
    station = Station.new("kingscross", 1)
    expect(station.zone).to eq 1
  end

end
