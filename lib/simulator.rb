require_relative './season'
require_relative './constants'
require_relative './team'

class Simulator
  attr_reader :season, :superbowl_wins

  SIMULATIONS = 10000

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
    SIMULATIONS.times do |s|
      winner = season.run
      superbowl_wins[winner.name.to_sym] += 1
    end
  end

  def create_teams
    NFL::TEAMS.each do |t|
      team = Team.new(t[:name], t[:conference], t[:division], t[:weighting])
      NFL::CONFERENCES[t[:conference].to_sym] << team
      NFL::DIVISIONS[t[:division].to_sym] << team
    end
  end

  def output_result(start_time)
    puts "#{SIMULATIONS} simulations, ran in #{Time.now - start_time} seconds"
    puts @superbowl_wins
  end
end

Simulator.new.run!
