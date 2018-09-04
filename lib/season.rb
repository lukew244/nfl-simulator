require_relative './constants'
require_relative './team'
require_relative './fixtures'
require_relative './game'

class Season

  def initialize
    @results = []
  end

  def run
    Team.reset_all_wins
    simulate_fixtures
    simulate_postseason
  end

  def simulate_fixtures
    FIXTURES.each do |f|
      Game.play(Team.find(f[:home]), Team.find(f[:away]))
    end
  end

  def simulate_postseason
    winners = []
    potential_wildcards = []
    NFL::DIVISIONS.each do |division|
      rankings = division.last.sort_by { |team| team.wins }.reverse
      winners << rankings.first
      potential_wildcards << rankings[1]
      potential_wildcards << rankings[2]
    end

    top_seeds = winners.partition {|t| t.conference == 'AFC' }
    wild_cards = potential_wildcards.partition {|t| t.conference == 'AFC' }
    afc_ranked = sort_teams(top_seeds.first) + sort_teams(wild_cards.first).first(2)
    nfc_ranked = sort_teams(top_seeds.last) + sort_teams(wild_cards.last).first(2)

    run_postseason(afc_ranked, nfc_ranked)
  end

  def sort_teams(teams)
    teams.sort_by(&:wins).reverse
  end

  def run_postseason(afc, nfc)
    superbowl = []
    [afc, nfc].each do |c|
      w1 = Game.play_postseason(c[2], c[5])
      w2 = Game.play_postseason(c[3], c[4])
      d1 = Game.play_postseason(c[0], w1)
      d2 = Game.play_postseason(c[1], w2)
      c1 = Game.play_postseason(d1, d2)
      superbowl << c1
    end
    Game.play_postseason(superbowl.first, superbowl.last)
  end
end
