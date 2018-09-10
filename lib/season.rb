require_relative './constants/fixtures'
require_relative './game'
require_relative './postseason_calculator'

class Season
  attr_reader :postseason_calculator

  def run
    reset_teams
    play_regular_season
    afc, nfc = PostseasonCalculator.run
    play_postseason(afc, nfc)
  end

  def play_regular_season
    NFL::FIXTURES.map { |f| Game.play(Team.find(f[:home]), Team.find(f[:away]))}
  end

  def play_postseason(afc, nfc)
    superbowl = []
    [afc, nfc].each do |seed|
      wildcard_winners = wildcard_round(seed)
      divisional_winners = divisional_round(seed, wildcard_winners)
      champion = Game.postseason(divisional_winners.first, divisional_winners.last)
      superbowl << champion
    end
    Game.postseason(superbowl.first, superbowl.last)
  end

  def wildcard_round(seed)
    wildcard_winner_1 = Game.postseason(seed[2], seed[5])
    wildcard_winner_2 = Game.postseason(seed[3], seed[4])
    seed_teams([wildcard_winner_1, wildcard_winner_2])
  end

  def divisional_round(seed, wildcard_winners)
    divisional_winner_1 = Game.postseason(seed[0], wildcard_winners.last)
    divisional_winner_2 = Game.postseason(seed[1], wildcard_winners.first)
    seed_teams([divisional_winner_1, divisional_winner_2])
  end

  def seed_teams(teams)
    teams.sort_by(&:wins).reverse
  end

  def reset_teams
    Team.reset_all_wins
  end
end
