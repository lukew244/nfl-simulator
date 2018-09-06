class Tiebreaker
  attr_reader :team_wins

  def initialize(team_wins)
    @team_wins = team_wins
  end

  def rank_division(division)
    win_order = order_by_wins(division)
    max_wins = win_order.map(&:wins)
    tied_teams = count_tied(max_wins)
    if tied_teams == 1
      return win_order
    elsif tied_teams == 2
      two_way_divisional_tiebreaker(win_order)
    else
      multi_way_divisional_tiebreaker(win_order)
    end
  end

  def multi_way_divisional_tiebreaker(win_order)
    return win_order
  end

  def two_way_divisional_tiebreaker(division)
    first_team_advantage = head_to_head(division[0].name, division[1].name)
    if first_team_advantage > 0
      return division
    elsif first_team_advantage < 0
      return switch_order(division)
    else
      return division_wins_tiebreaker(division)
    end
  end

  def switch_order(division)
    division[0], division[1] = division[1], division[0]
    division
  end

  def division_wins_tiebreaker(division)
    first_team_advantage = division_wins(division)
    if first_team_advantage > 0
      return division
    elsif first_team_advantage < 0
      return switch_order(division)
    else
      return division
    end
  end

  def head_to_head(team_1, team_2)
    team_wins[team_1].count { |beat| beat == team_2 } -
    team_wins[team_2].count { |beat| beat == team_1 }
  end

  def division_wins(division)
    teams = division.map(&:name)
    team_wins[teams[0]].count { |beat| teams.include?(beat) } -
    team_wins[teams[1]].count { |beat| teams.include?(beat) }
  end

  def count_tied(wins)
    wins.each_index.select { |i| wins[i] == wins[0] }.count
  end

  def order_by_wins(division)
    division.last.sort_by { |team| team.wins }.reverse
  end
end
