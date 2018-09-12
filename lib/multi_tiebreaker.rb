module MultiTiebreaker
  extend self

  TIEBREAKERS = ['head_to_head', 'coin_toss']
# , 'division_wins', 'common_games', 'conference_wins',

  def division(teams, tiebreaker)
    teams_and_records = TIEBREAKERS.find { |tb| tb = self.send(tb.to_sym, teams); break tb if tb.last != 1 }
    teams_and_records.pop
    tied_teams, eliminated = split_eliminated(teams_and_records)
    if tied_teams.count == 1
      return (tied_teams + eliminated).flatten
    elsif tied_teams.count == 2
      (tiebreaker.two_way_tiebreaker(tied_teams) + eliminated).flatten
    else
      return division(tied_teams, tiebreaker)
    end
  end

  def head_to_head(teams)
    team_names = teams.map(&:name)
    wins = teams.map do |team|
      count = team.teams_beat.count { |beat| team_names.include?(beat) }
      [team, count]
    end
    wins << wins.map(&:last).uniq.count
  end

  def coin_toss(teams)
    order = teams.each_with_index.map { |t, i| [t, i] }
    order << 0
  end

  def split_eliminated(teams)
    tied_count = count_tied(teams)
    teams = teams.sort_by(&:last).reverse.map(&:first)
    teams.partition.with_index { |_, index| index < tied_count }
  end

  def count_tied(teams)
    teams.count { |team_record| team_record[1] == best_record(teams) }
  end

  def best_record(teams_in_order)
    teams_in_order[0][1]
  end
end
