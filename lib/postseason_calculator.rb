require_relative './tiebreaker'

module PostseasonCalculator

  def self.run
    division_winners = []
    potential_wildcards = []
    tiebreaker = Tiebreaker.new
    NFL::DIVISIONS.each do |division|
      rankings = tiebreaker.rank_division(division.last)
      division_winners    << rankings[0]
      potential_wildcards << rankings[1] << rankings[2]
    end

    top_seeds = sort_by_conference(division_winners)
    wild_cards = sort_by_conference(potential_wildcards)
    afc_seeds = seed_teams(top_seeds.first) + seed_teams(wild_cards.first).first(2)
    nfc_seeds = seed_teams(top_seeds.last) + seed_teams(wild_cards.last).first(2)
    return afc_seeds, nfc_seeds
  end

  def self.sort_by_conference(teams)
    teams.partition {|t| t.conference == 'AFC' }
  end

  def self.seed_teams(teams)
    teams.sort_by(&:wins).reverse
  end

end
