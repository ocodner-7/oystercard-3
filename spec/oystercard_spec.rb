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
end