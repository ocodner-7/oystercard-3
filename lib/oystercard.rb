
class Oystercard
  CARDLIMIT = 90
  MINIMUM_BALANCE = 1
  MINIMUM_CHARGE = 1


  def initialize(balance: 0, entry_station: nil, history: [] )
    @balance = balance
    @entry_station = entry_station
    @history = history
  end
  
  
  def top_up(number)
    fail "Not topped up, over £#{CARDLIMIT} limit" if card_limit?(number)
    @balance += number 
  end
  
  def touch_in(entry_station)
    fail 'Insufficient funds' if card_minimum?
    @entry_station = entry_station
  end
  
  def touch_out(station)
    deduct(MINIMUM_CHARGE)
    add_journey(station)
    @entry_station = nil
  end
  
  def add_journey(station)
    @history.push({entry_station: @entry_station, exit_station: station})
  end
  
  def in_journey?
    @entry_station != nil
  end
  
  def balance
    @balance
  end
  
  def entry_station
    @entry_station
  end
  
  def history
    @history
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
