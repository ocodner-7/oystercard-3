require_relative "../lib/station.rb"

describe "Station" do
  describe "#station_info" do
    it "Should store and return station info" do 
      station = Station.new("Oxford Road", 1)
      expect(station.station_info).to(eq(["Oxford Road", 1]))
    end  
  end

  describe "#name" do
    it "should return the station when called" do
      station = Station.new("Oxford Road", 1)
      expect(station.name).to eq "Oxford Road"
    end
  end

  describe "zone" do
    it "should return the zone when called" do 
      station = Station.new("Oxford Road", 1)
      expect(station.zone).to eq 1
    end
  end
end