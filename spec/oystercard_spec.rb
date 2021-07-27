require 'oystercard'

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
      maximum_balance = Oystercard::CARDLIMIT
      subject.top_up maximum_balance
      expect { subject.top_up 1 }.to raise_error("Not topped up, over £#{maximum_balance} limit")
    end
  end
  
  describe "#deduct_from_card" do
    it "deducts the balance with the amount stated" do
      my_card = Oystercard.new
      my_card.top_up(5)
      expect(my_card.deduct_from_card(4)).to eq(1)
    end
  end
  
  describe "#in_journey?" do
    it "tells us if a card is in a journey" do
      my_card = Oystercard.new
      my_card.top_up(5)
      my_card.touch_in("Oxford Circus")
      expect(my_card).to be_in_journey
    end
    it "tells us a card is not in a journey" do
      my_card = Oystercard.new
      my_card.touch_out
      expect(my_card).not_to be_in_journey
    end

    it 'denies user if their balance is less than £1' do
      my_card_2 = Oystercard.new 
      my_card_2.top_up(0.5)
      expect{my_card_2.touch_in("Oxford Circus")}.to raise_error 'Insufficient funds'
    end
  end
  
  describe '#touch_out' do
    it "charges correct amount from card" do
      card = Oystercard.new
      card.top_up(5)
      card.touch_in("Oxford Circus")
      expect {card.touch_out}.to change{card.balance}.by(-Oystercard::MINIMUM_CHARGE)
    end
    it "sets the entry station back to nil" do
      card = Oystercard.new
      card.top_up(5)
      card.touch_in("Oxford Circus")
      card.touch_out
      expect(card.entry_station).to eq nil
    end
  end

  describe "#touch_in" do
    let(:station){double :station}
    it "remembers the entry station" do
      new_card = Oystercard.new
      new_card.top_up(5)
      new_card.touch_in(station)
      expect(new_card.entry_station).to eq station
    end
  end

end
