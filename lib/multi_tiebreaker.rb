module MultiTiebreaker

  def self.division(division, tied_teams_count, tiebreaker)
    sorted_order, tied_teams = head_to_head(division, tied_teams_count)
    if tied_teams == 1
      return sorted_order
    elsif tied_teams == 2
      tiebreaker.head_to_head_tiebreaker(division)
    else
      puts 'three tied'
      return sorted_order #next step
    end
  end

  def self.head_to_head(division, tied_teams_count)
      tied_teams, out = division.partition.with_index { |_, index| index < tied_teams_count }
      team_names = tied_teams.map(&:name)
      wins = tied_teams.map do |team|
        count = team.teams_beat.count { |beat| team_names.include?(beat) }
        [team, count]
      end
      ordered_array = wins.sort_by(&:last).reverse
      still_tied = ordered_array.count { |e| e[1] == ordered_array[0][1] }
      sorted_teams = ordered_array.map { |team| team[0] } + out
      return sorted_teams, still_tied
    end

  def self.divisional_tiebreaker(division, tied_teams_count)
    sorted_order, tied_teams = multi_division_tiebreaker(division, tied_teams_count)
    if tied_teams == 1
      return sorted_order
    elsif tied_teams == 2
      head_to_head_tiebreaker(division)
    else
      puts 'three tied'
      return sorted_order #next step
    end
  end
end
