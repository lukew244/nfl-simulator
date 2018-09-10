require_relative './constants/non_div_opponents'
require_relative './multi_tiebreaker'
class Tiebreaker

  def rank_division(division_as_array)
    division_in_win_order = order_by_wins(division_as_array)
    tied_teams, eliminated = split_eliminated(division_in_win_order)
    if tied_teams.count == 1
      return division_in_win_order
    elsif tied_teams.count == 2
      head_to_head_tiebreaker(tied_teams) + eliminated
    else
      MultiTiebreaker.division(tied_teams, self) + eliminated
    end
  end

  def split_eliminated(teams)
    tied_count = count_tied(teams)
    teams.partition.with_index { |_, index| index < tied_count }
  end

  def head_to_head_tiebreaker(teams)
    first_team_advantage = head_to_head(teams)
    run_tiebreaker(first_team_advantage, teams) {|teams| division_wins_tiebreaker(teams)}
  end

  def division_wins_tiebreaker(teams)
    first_team_advantage = division_wins(teams)
    run_tiebreaker(first_team_advantage, teams) {|teams| common_games_tiebreaker(teams)}
  end

  def common_games_tiebreaker(teams)
    first_team_advantage = common_games(teams)
    run_tiebreaker(first_team_advantage, teams) {|teams| conference_wins_tiebreaker(teams) }
  end

  def conference_wins_tiebreaker(teams)
    first_team_advantage = conference_wins(teams)
    run_tiebreaker(first_team_advantage, teams) {|teams| coin_toss(teams) }
  end

  def coin_toss(teams)
    return teams
  end

  def run_tiebreaker(first_team_advantage, teams)
    if first_team_advantage > 0
      return teams
    elsif first_team_advantage < 0
      return switch_order(teams)
    else
      yield(teams)
    end
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
    (common & tied.first.teams_beat).count - (common & tied.last.teams_beat).count
  end

  def conference_wins(tied)
    tied.first.conference_wins - tied.last.conference_wins
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
