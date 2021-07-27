
class Oystercard
  CARDLIMIT = 90
  attr_reader :balance, :cardlimit

  def initialize
    @balance = 0
    @cardlimit = CARDLIMIT
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
    @in_journey = true
  end

  def touch_out
    @in_journey = false
  end

  def in_journey?
    @in_journey
  end

end
