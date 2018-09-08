module Game
  def self.play(home, away)
    division = division_game?(home, away)
    conference = conference_game?(division, home, away)
    result = rand(10)
    if result >= 5
      home.record_win(division, conference)
      home.teams_beat << away.name
      [home.name, away.name]
    else
      away.record_win(division, conference)
      away.teams_beat << home.name
      [away.name, home.name]

    end
  end

  def self.division_game?(home, away)
    home.division == away.division
  end

  def self.conference_game?(division, home, away)
    return true if division
    home.conference == away.conference
  end

  def self.postseason(home, away)
    result = rand(10)
    result >= 5 ? home : away
  end
end
