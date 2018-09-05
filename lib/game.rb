module Game
  def self.play(home, away)
    result = rand(10)
    if result >= 5
      home.record_win
      [home.name, away.name]
    else
      away.record_win
      [away.name, home.name]
    end
  end

  def self.postseason(home, away)
    result = rand(10)
    result >= 5 ? home : away
  end
end
