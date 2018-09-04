class Team
  attr_reader :name, :conference, :division, :weighting, :wins

  @@instances = []

  def initialize(name, conference, division, weighting)
    @name = name
    @conference = conference
    @division = division
    @weighting = weighting
    @wins = 0
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

  def record_win
    @wins += 1
  end

  def reset_wins
    @wins = 0
  end

end
