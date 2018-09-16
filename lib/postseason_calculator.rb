require_relative './tiebreaker'
require_relative './playoff_seeder'

module PostseasonCalculator
  extend self

  def run
    afc_seeds = run_conference(NFL::AFC)
    nfc_seeds = run_conference(NFL::NFC)
    return afc_seeds, nfc_seeds
  end

  def run_conference(conference)
    division_winners = []
    potential_wildcards = []

    conference.each do |division|
      rankings = Tiebreaker.rank_division(division.last)
      division_winners    << rankings[0]
      potential_wildcards << rankings[1] << rankings[2]
    end
    seed_winners(division_winners) + fill_wildcards(potential_wildcards)
  end

  def fill_wildcards(teams)
    PlayoffSeeder.wildcards(teams)
  end

  def seed_winners(teams)
    PlayoffSeeder.division_winners(teams)
  end
end
