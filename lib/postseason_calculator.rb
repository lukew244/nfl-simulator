require_relative './tiebreaker'
require_relative './playoff_seeder'

module PostseasonCalculator
  extend self

  def run
    division_winners = []
    potential_wildcards = []
    NFL::DIVISIONS.each do |division|
      rankings = Tiebreaker.rank_division(division.last)
      division_winners    << rankings[0]
      potential_wildcards << rankings[1] << rankings[2]
    end

    top_seeds = split_by_conference(division_winners)
    wildcards = split_by_conference(potential_wildcards)
    afc_seeds = seed_winners(top_seeds.first) + fill_wildcards(wildcards.first)
    nfc_seeds = seed_winners(top_seeds.last) + fill_wildcards(wildcards.last)
    return afc_seeds, nfc_seeds
  end

  def split_by_conference(teams)
    teams.partition {|t| t.conference == 'AFC' }
  end

  def fill_wildcards(teams)
    PlayoffSeeder.wildcards(teams)
  end

  def seed_winners(teams)
    PlayoffSeeder.division_winners(teams)
  end
end
