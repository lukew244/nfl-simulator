require_relative './constants/non_div_opponents'

module SingleTiebreaker
  extend self

  TIEBREAKERS = %w[head_to_head division_wins common_games conference_wins coin_toss]

  def run(teams)
    first_team_advantage = TIEBREAKERS.find { |tb| tb = self.send(tb, teams); break tb if tb != 0 }
    sort_teams(first_team_advantage, teams)
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
end
