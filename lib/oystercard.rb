
class Oystercard
  CARDLIMIT = 90
  MINIMUM_BALANCE = 1
  MINIMUM_CHARGE = 1
  attr_reader :balance, :cardlimit, :minimum_balance, :minimum_charge, :entry_station

  def initialize
    @balance = 0
    @cardlimit = CARDLIMIT
    @minimum_balance = MINIMUM_BALANCE
    @minimum_charge = MINIMUM_CHARGE
    @entry_station = nil
  end

  def top_up(number)
  fail "Not topped up, over £#{CARDLIMIT} limit" if (@balance += number) > CARDLIMIT 
  #return @balance += number 
  end

  def deduct_from_card(number)
    return @balance -= number
  end

  def touch_in(entry_station)
    fail 'Insufficient funds' if @balance < MINIMUM_BALANCE
    @entry_station = entry_station
  end

  def touch_out
    deduct(MINIMUM_CHARGE)
    @entry_station = nil
  end

  def in_journey?
    return true if @entry_station != nil
  end

  private
  
  def deduct(charge)
     @balance -= charge
  end
end
