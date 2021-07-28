
class Oystercard
  CARDLIMIT = 90
  MINIMUM_BALANCE = 1
  MINIMUM_CHARGE = 1
  attr_reader :balance, :entry_station

  def initialize(balance: 0, entry_station: nil )
    @balance = balance
    @entry_station = entry_station
  end

  def top_up(number)
    fail "Not topped up, over £#{CARDLIMIT} limit" if card_limit?(number)
    @balance += number 
  end

  def touch_in(entry_station)
    fail 'Insufficient funds' if card_minimum?
    @entry_station = entry_station
  end

  def touch_out
    deduct(MINIMUM_CHARGE)
    @entry_station = nil
  end

  def in_journey?
    @entry_station != nil
  end

  private
  
  def deduct(charge)
     @balance -= charge
  end
  
  def card_limit?(number)
    (@balance + number) > CARDLIMIT
  end
  
  def card_minimum?
    @balance < MINIMUM_BALANCE
  end
end
