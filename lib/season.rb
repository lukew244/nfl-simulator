require_relative './fixtures'
require_relative './game'

class Season
  attr_reader :teams_beaten

  def initialize
    @teams_beaten = Hash.new { |h, k| h[k] = [] }
  end

  def run
    reset_teams
    play_regular_season
    calculate_postseason
  end

  def play_regular_season
    b = FIXTURES.map { |f| Game.play(Team.find(f[:home]), Team.find(f[:away]))}
      .map { |result| teams_beaten[result[0]] << result[1] }
  end

  def calculate_postseason
    division_winners = []
    potential_wildcards = []
    NFL::DIVISIONS.each do |division|
      rankings = rank_teams(division)
      division_winners    << rankings[0]
      potential_wildcards << rankings[1]
      potential_wildcards << rankings[2]
    end

    top_seeds = sort_by_conference(division_winners)
    wild_cards = sort_by_conference(potential_wildcards)
    afc_seeds = seed_teams(top_seeds.first) + seed_teams(wild_cards.first).first(2)
    nfc_seeds = seed_teams(top_seeds.last) + seed_teams(wild_cards.last).first(2)
    play_postseason(afc_seeds, nfc_seeds)
  end

  def play_postseason(afc, nfc)
    superbowl = []
    [afc, nfc].each do |seed|
      wildcard_winner_1 = Game.postseason(seed[2], seed[5])
      wildcard_winner_2 = Game.postseason(seed[3], seed[4])
      wildcard_winners = seed_teams([wildcard_winner_1, wildcard_winner_2])

      divisional_winner_1 = Game.postseason(seed[0], wildcard_winners.last)
      divisional_winner_2 = Game.postseason(seed[1], wildcard_winners.first)
      divisional_winners = seed_teams([divisional_winner_1, divisional_winner_2])

      champion = Game.postseason(divisional_winners.first, divisional_winners.last)
      superbowl << champion
    end
    Game.postseason(superbowl.first, superbowl.last)
  end

  def rank_teams(division)
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

  def seed_teams(teams)
    teams.sort_by(&:wins).reverse
  end

  def sort_by_conference(teams)
    teams.partition {|t| t.conference == 'AFC' }
  end

  def reset_teams
    Team.reset_all_wins
  end
end
