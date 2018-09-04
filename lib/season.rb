require_relative './fixtures'
require_relative './game'
require_relative './postseason_calculator'
class Season

  def initialize
    @results = []

  end

  def run
    reset_teams
    play_regular_season
    calculate_postseason
  end

  def play_regular_season
    FIXTURES.each { |f| Game.play(Team.find(f[:home]), Team.find(f[:away]))}
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
    wins = win_order.map(&:wins)
    if clear_winner?(wins)
      return win_order
    else
      return win_order #divisional tiebreaker procedure goes here
    end
  end

  def clear_winner?(wins)
    wins.each_index.select { |i| wins[i] == wins[0] }.count > 1
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
