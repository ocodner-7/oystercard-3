class Station
  def initialize(name, zone)
    @name = name
    @zone = zone
  end

  def name
    @name
  end

  def zone
    @zone
  end

  def station_info
    [@name, @zone]
  end
end