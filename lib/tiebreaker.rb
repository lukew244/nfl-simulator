require_relative './constants/non_div_opponents'
require_relative './multi_tiebreaker'
class Tiebreaker

  def rank_division(division_as_array)
    division_in_win_order = order_by_wins(division_as_array)
    tied_teams = count_tied(division_in_win_order)
    if tied_teams == 1
      return division_in_win_order
    elsif tied_teams == 2
      head_to_head_tiebreaker(division_in_win_order)
    else
      MultiTiebreaker.division(division_in_win_order, tied_teams, self)
    end
  end

  def head_to_head_tiebreaker(division)
    first_team_advantage = head_to_head(division)
    run_tiebreaker(first_team_advantage, division) {|division| division_wins_tiebreaker(division)}
  end

  def division_wins_tiebreaker(division)
    first_team_advantage = division_wins(division)
    run_tiebreaker(first_team_advantage, division) {|division| common_games_tiebreaker(division)}
  end

  def common_games_tiebreaker(division)
    first_team_advantage = common_games(division)
    run_tiebreaker(first_team_advantage, division) {|division| conference_wins_tiebreaker(division) }
  end

  def conference_wins_tiebreaker(division)
    first_team_advantage = conference_wins(division)
    run_tiebreaker(first_team_advantage, division) {|division| coin_toss(division) }
  end

  def coin_toss(division)
    return division
  end

  def run_tiebreaker(first_team_advantage, division)
    if first_team_advantage > 0
      return division
    elsif first_team_advantage < 0
      return switch_order(division)
    else
      yield(division)
    end
  end

  def head_to_head(division)
    division[0].teams_beat.count { |beat| beat == division[1].name } -
    division[1].teams_beat.count { |beat| beat == division[0].name }
  end

  def division_wins(division)
    division[0].division_wins - division[1].division_wins
  end

  def common_games(division)
    common = NFL::NON_DIV_OPPONENTS[division[0].name] & NFL::NON_DIV_OPPONENTS[division[1].name]
    (common & division[0].teams_beat).count - (common & division[1].teams_beat).count
  end

  def conference_wins(division)
    division[0].conference_wins - division[1].conference_wins
  end

  def switch_order(division)
    division[0], division[1] = division[1], division[0]
    division
  end

  def count_tied(division)
    wins = division.map(&:wins)
    wins.each_index.select { |i| wins[i] == wins[0] }.count
  end

  def order_by_wins(division)
    division.sort_by { |team| team.wins }.reverse
  end
end
