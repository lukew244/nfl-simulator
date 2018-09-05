class Tiebreaker
  attr_reader :teams_beaten

  def initialize(teams_beaten)
    @teams_beaten = teams_beaten
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

  def two_way_divisional_tiebreaker(division)
    first_team_advantage = head_to_head(division[0].name, division[1].name)
    if first_team_advantage > 0
      return division
    elsif first_team_advantage < 0
      division[0], division[1] = division[1], division[0]
      return division
    else
      return division
    end
  end

  def multi_way_divisional_tiebreaker(win_order)
    return win_order
  end

  def head_to_head(team_1, team_2)
    teams_beaten[team_1].count { |beat| beat == team_2} -
    teams_beaten[team_2].count { |beat| beat == team_1}
  end

  def count_tied(wins)
    wins.each_index.select { |i| wins[i] == wins[0] }.count
  end

  def order_by_wins(division)
    division.last.sort_by { |team| team.wins }.reverse
  end

end
