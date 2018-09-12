require_relative './constants/non_div_opponents'
require_relative './multi_tiebreaker'
class Tiebreaker

  DIVISION_TIEBREAKERS = ['head_to_head', 'division_wins', 'common_games', 'conference_wins', 'coin_toss']

  def rank_division(division_as_array)
    division_in_win_order = order_by_wins(division_as_array)
    tied_teams, eliminated = split_eliminated(division_in_win_order)
    if tied_teams.count == 1
      return division_in_win_order
    elsif tied_teams.count == 2
      two_way_tiebreaker(tied_teams) + eliminated
    else
      MultiTiebreaker.division(tied_teams, self) + eliminated
    end
  end

  def two_way_tiebreaker(teams)
    first_team_advantage = DIVISION_TIEBREAKERS.find { |tb| tb = self.send(tb.to_sym, teams); break tb if tb != 0 }
    sort_teams(first_team_advantage, teams)
  end

  def split_eliminated(teams)
    tied_count = count_tied(teams)
    teams.partition.with_index { |_, index| index < tied_count }
  end

  def sort_teams(first_team_advantage, teams)
    first_team_advantage > 0 ? teams : switch_order(teams)
  end

  def head_to_head(tied)
    tied.first.teams_beat.count { |beat| beat == tied.last.name } -
    tied.last.teams_beat.count { |beat| beat == tied.first.name }
  end

  def division_wins(tied)
    tied.first.division_wins - tied.last.division_wins
  end

  def common_games(tied)
    common = NFL::NON_DIV_OPPONENTS[tied.first.name] & NFL::NON_DIV_OPPONENTS[tied.last.name]
    (common & tied.first.teams_beat).count - (common & tied.last.teams_beat).count #BUG: set intersection expects unique entries
  end

  def conference_wins(tied)
    tied.first.conference_wins - tied.last.conference_wins
  end

  def coin_toss(teams)
    return 1
  end

  def switch_order(tied)
    tied[0], tied[1] = tied[1], tied[0]
    tied
  end

  def count_tied(division)
    wins = division.map(&:wins)
    wins.each_index.select { |i| wins[i] == wins[0] }.count
  end

  def order_by_wins(division)
    division.sort_by { |team| team.wins }.reverse
  end
end
