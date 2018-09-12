require_relative './constants/league'
require_relative './season'
require_relative './team'

class Simulator
  attr_reader :season, :superbowl_wins

  SIMULATIONS = 15000

  def initialize
    @season = Season.new
    @superbowl_wins = Hash.new(0)
  end

  def run!
    start = Time.now
    create_teams
    run_simulations
    output_result(start)
  end

  def run_simulations
    SIMULATIONS.times do
      winner = season.run
      superbowl_wins[winner.name.to_sym] += 1
    end
  end

  def create_teams
    NFL::TEAMS.each do |team_data|
      team = create_team(team_data)
      add_to_league(team, team_data[:conference], team_data[:division])
    end
  end

  def create_team(team)
    Team.new(team[:name], team[:conference], team[:division], team[:weighting])
  end

  def add_to_league(team, conference, division)
    NFL::CONFERENCES[conference.to_sym] << team
    NFL::DIVISIONS[division.to_sym] << team
  end

  def output_result(start_time)
    puts "#{SIMULATIONS} simulations, ran in #{Time.now - start_time} seconds"
    puts @superbowl_wins
  end
end

Simulator.new.run!
