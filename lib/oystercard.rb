
class Oystercard
  CARDLIMIT = 90
  attr_reader :balance, :cardlimit

  def initialize
    @balance = 0
    @cardlimit = CARDLIMIT
  end

  def top_up(number)
  fail "Not topped up, over £#{CARDLIMIT} limit" if (@balance += number) > CARDLIMIT 
  #return @balance += number 
  end

  def deduct_from_card(number)
    return @balance -= number
  end
end
