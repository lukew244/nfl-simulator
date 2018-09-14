require_relative './single_tiebreaker'
require_relative './multi_tiebreaker'

module PlayoffSeeder
  extend self

  def division_winners(teams)
    sorted = []
    teams_in_win_order(teams).each_index do |i|
      next if sorted.length > i
      tied_for_place = select_tied(teams, i)
      if tied_for_place.length == 1
        sorted += tied_for_place
      elsif tied_for_place.length == 2
        sorted += SingleTiebreaker.division_winners(tied_for_place)
      else
        sorted += MultiTiebreaker.playoff(tied_for_place)
      end
    end
    sorted
  end

  def wildcards(teams)
    wildcards = []
    teams_in_win_order(teams).each_index do |i|
      break if wildcards.length >= 2
      tied_for_place = select_tied(teams, i)
      if tied_for_place.length == 1
        wildcards += tied_for_place
      elsif tied_for_place.length == 2
        wildcards += two_way_tiebreaker(tied_for_place)
        wildcards = wildcards.first(2)
      else
        wildcards += MultiTiebreaker.playoff(tied_for_place)
        wildcards = wildcards.first(2)
      end
    end
    wildcards
  end

  def two_way_tiebreaker(teams)
    if teams.first.division == teams.last.division
      SingleTiebreaker.run(tied_for_place)
    else
      SingleTiebreaker.division_winners(tied_for_place)
    end
  end

  def teams_in_win_order(teams)
    teams.sort_by(&:wins).reverse
  end

  def select_tied(teams, index)
    teams.select { |t| t.wins == teams[index].wins }
  end
end
