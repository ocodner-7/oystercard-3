require_relative '../lib/oystercard.rb'

describe Oystercard do
  it "has a default value of 0" do
    expect(Oystercard.new.balance).to eq(0)
  end
  
  describe "#top_up" do
    it "tops up my balance with the amount stated" do
      my_card = Oystercard.new
      my_card.top_up(5)
      expect(my_card.balance).to eq 5
    end
    it "top_up does not allow a balance over £90" do
      my_card = Oystercard.new
      subject.top_up(Oystercard::CARDLIMIT)
      expect { subject.top_up 1 }.to raise_error("Not topped up, over £#{Oystercard::CARDLIMIT} limit")
    end
  end
  
  describe "#deduct_from_card" do
    before(:each) do
      @my_card = Oystercard.new(:balance => 5)
    end
    it "deducts the balance with the amount stated" do
      expect{@my_card.touch_out("Victoria", 3)}.to change {@my_card.balance}.by -1
    end
  end
  
  describe "#in_journey?" do
    before(:each) do
      @my_card = Oystercard.new
    end
    it "tells us if a card is in a journey" do
      @my_card.top_up(5)
      @my_card.touch_in("Oxford Circus", 1)
      expect(@my_card).to be_in_journey
    end
    it "tells us a card is not in a journey" do
      @my_card.touch_out("Victoria", 3)
      expect(@my_card).not_to be_in_journey
    end

    it 'denies user if their balance is less than £1' do
      expect{@my_card.touch_in("Oxford Circus", 1)}.to raise_error 'Insufficient funds'
    end
  end
  
  describe '#touch_out' do
    before(:each) do
      @card = Oystercard.new(:balance => 5)
    end
    it "charges correct amount from card" do
      @card.touch_in("Oxford Circus", 1)
      expect {@card.touch_out("Victoria", 3)}.to change{@card.balance}.by(-Oystercard::MINIMUM_CHARGE)
    end
    it "sets the entry station back to nil" do
      @card.touch_in("Oxford Circus",1)
      @card.touch_out("Victoria", 3)
      expect(@card.entry_station).to eq nil
    end
  end

  describe "#touch_in" do
    it "remembers the entry station" do
      new_card = Oystercard.new
      new_card.top_up(5)
      new_card.touch_in("Oxford Road", 1)
      expect(new_card.entry_station).to_not be_nil
    end
  end

  describe "#add_journey" do
    before(:each) do
    end

    it "will add and store a journey in history" do
      card = Oystercard.new(:balance => 10)
      card.touch_in("Oxford Road", 1)
      card.touch_out("Victoria", 3)
      expect([card.history[0][:entry_station].station_info,
              card.history[0][:exit_station].station_info]
              ).to(eq [["Oxford Road", 1], ["Victoria", 3]])
    end
  end
end
