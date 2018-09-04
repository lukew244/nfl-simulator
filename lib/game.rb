module Game
  def self.play(home, away)
    result = rand(10)
    if result >= 5
      home.record_win
    else
      away.record_win
    end
    nil
  end

  def self.play_postseason(home, away)
    result = rand(10)
    result >= 5 ? home : away
  end
end
