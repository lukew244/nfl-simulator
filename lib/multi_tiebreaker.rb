module MultiTiebreaker

  def self.division(teams, tiebreaker)
    teams_and_wins = head_to_head(teams)
    tied_teams, eliminated = split_eliminated(teams_and_wins)
    if tied_teams.count == 1
      return (tied_teams + eliminated).flatten
    elsif tied_teams.count == 2
      tiebreaker.head_to_head_tiebreaker(tied_teams) + eliminated
    else
      return teams_in_head_to_head_order #next step
    end
  end

  def self.head_to_head(teams)
      team_names = teams.map(&:name)
      wins = teams.map do |team|
        count = team.teams_beat.count { |beat| team_names.include?(beat) }
        [team, count]
      end
      teams_in_order = wins.sort_by(&:last).reverse
    end

    def self.split_eliminated(teams)
      tied_count = teams.count { |team_record| team_record[1] == best_record(teams) }
      teams.partition.with_index { |_, index| index < tied_count }
    end

    def self.best_record(teams_in_order)
      teams_in_order[0][1]
    end

    def self.count_tied(division)
      wins = division.map(&:wins)
      wins.each_index.select { |i| wins[i] == wins[0] }.count
    end

  # def self.divisional_tiebreaker(division, tied_teams_count)
  #   sorted_order, tied_teams = multi_division_tiebreaker(division, tied_teams_count)
  #   if tied_teams == 1
  #     return sorted_order
  #   elsif tied_teams == 2
  #     head_to_head_tiebreaker(division)
  #   else
  #     puts 'three tied'
  #     return sorted_order #next step
  #   end
  # end
end
