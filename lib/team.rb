class Team
  attr_reader :name, :conference, :division, :weighting, :wins,
    :division_wins, :conference_wins, :teams_beat

  @@instances = []

  def initialize(name, conference, division, weighting)
    @name = name
    @conference = conference
    @division = division
    @weighting = weighting
    @wins = 0
    @division_wins = 0
    @conference_wins = 0
    @teams_beat = []
    @@instances << self
  end

  def self.all
    @@instances
  end

  def self.find(name)
    self.all.find { |t| t.name == name }
  end

  def self.reset_all_wins
    self.all.each { |t| t.reset_wins }
  end

  def record_win(division, conference)
    @wins += 1
    @division_wins += 1 if division
    @conference_wins += 1 if conference
  end

  def reset_wins
    @wins = 0
    @division_wins = 0
    @conference_wins = 0
    @teams_beat = []
  end

end
