module MultiTiebreaker
  extend self

  TIEBREAKERS = %w[head_to_head division_wins conference_wins coin_toss]
  # 'common_games'
  DIV_WINNER_TIEBREAKERS = %w[head_to_head conference_wins coin_toss]

  def division(teams)
    teams_and_records = find_successful_tiebreaker(teams)
    tied_teams, eliminated = split_eliminated(teams_and_records)
    if tied_teams.count == 1
      return (tied_teams + eliminated).flatten
    elsif tied_teams.count == 2
      (SingleTiebreaker.run(tied_teams) + eliminated).flatten
    else
      return division(tied_teams)
    end
  end

  def playoff(teams)
    teams_and_records = find_successful_tiebreaker(teams, DIV_WINNER_TIEBREAKERS)
    tied_teams, eliminated = split_eliminated(teams_and_records)
    if tied_teams.count == 1
      return (tied_teams + eliminated).flatten
    elsif tied_teams.count == 2
      (SingleTiebreaker.run(tied_teams) + eliminated).flatten
    else
      return division(tied_teams)
    end
  end

  def find_successful_tiebreaker(teams, tiebreakers=TIEBREAKERS)
    tiebreakers.find { |tb| tb = self.send(tb, teams); break tb if tb.last != 0 }
  end

  def head_to_head(teams)
    wins = teams.map { |team| head_to_head_wins(team, teams.map(&:name)) }
    wins << teams.count - count_tied(wins)
  end

  def division_wins(teams)
    wins = teams.map { |team| [team, team.division_wins] }
    wins << teams.count - count_tied(wins)
  end

  def conference_wins(teams)
    wins = teams.map { |team| [team, team.conference_wins] }
    wins << teams.count - count_tied(wins)
  end

  def coin_toss(teams)
    order = teams.each_with_index.map { |t, i| [t, i] }
    order << 1
  end

  def split_eliminated(teams)
    tied_count = teams.pop
    teams = order(teams)
    teams.partition.with_index { |_, index| index < tied_count }
  end

  def head_to_head_wins(team, tied_teams)
    count = team.teams_beat.count { |beat| tied_teams.include?(beat) }
    [team, count]
  end

  def count_tied(teams)
    teams.count { |team_record| team_record[1] == best_record(teams) }
  end

  def best_record(teams_in_order)
    teams_in_order[0][1]
  end

  def order(teams)
    teams.sort_by(&:last).reverse.map(&:first)
  end
end
