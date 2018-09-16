require_relative './single_tiebreaker'
require_relative './multi_tiebreaker'
module Tiebreaker
  extend self

  def rank_division(division_as_array)
    division_in_win_order = order_by_wins(division_as_array)
    tied_teams, eliminated = split_eliminated(division_in_win_order)
    if tied_teams.count == 1
      return division_in_win_order
    elsif tied_teams.count == 2
      SingleTiebreaker.run(tied_teams) + eliminated
    else
      MultiTiebreaker.run(tied_teams) + eliminated
    end
  end

  def split_eliminated(teams)
    tied_count = count_tied(teams)
    teams.partition.with_index { |_, index| index < tied_count }
  end

  def count_tied(division)
    wins = division.map(&:wins)
    wins.each_index.select { |i| wins[i] == wins[0] }.count
  end

  def order_by_wins(division)
    division.sort_by { |team| team.wins }.reverse
  end
end
