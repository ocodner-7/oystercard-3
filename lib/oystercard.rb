
class Oystercard
  CARDLIMIT = 90
  attr_reader :balance, :cardlimit

  def initialize
    @balance = 0
    @cardlimit = CARDLIMIT
  end

  def top_up(number)
  fail "Not topped up, over £#{CARDLIMIT} limit" if (@balance += number) > CARDLIMIT 
  "test" 
  end

end