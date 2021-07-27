
class Oystercard
  CARDLIMIT = 90
  MINIMUM_BALANCE = 1
  MINIMUM_CHARGE = 1
  attr_reader :balance, :cardlimit, :minimum_balance, :minimum_charge

  def initialize
    @balance = 0
    @cardlimit = CARDLIMIT
    @minimum_balance = MINIMUM_BALANCE
    @minimum_charge = MINIMUM_CHARGE
    @in_journey = nil
  end

  def top_up(number)
  fail "Not topped up, over £#{CARDLIMIT} limit" if (@balance += number) > CARDLIMIT 
  #return @balance += number 
  end

  def deduct_from_card(number)
    return @balance -= number
  end

  def touch_in
    fail 'Insufficient funds' if @balance < MINIMUM_BALANCE
    @in_journey = true
  end

  def touch_out
    deduct(MINIMUM_CHARGE)
    @in_journey = false
  end

  def in_journey?
    @in_journey
  end

  private
  
  def deduct(charge)
     @balance -= charge
  end
end
