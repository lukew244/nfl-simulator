require_relative './season'
require_relative './constants'
require_relative './team'

class Simulator

  def initialize
    @season = Season.new
  end

  def create_teams
    NFL::TEAMS.each do |t|
      team = Team.new(t[:name], t[:conference], t[:division], t[:weighting])
      NFL::CONFERENCES[t[:conference].to_sym] << team
      NFL::DIVISIONS[t[:division].to_sym] << team
    end
  end

  def run
    start = Time.now
    create_teams
    10000.times { @season.run }
    execution_time = Time.now - start
  end

end
