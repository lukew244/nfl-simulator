require_relative '../../lib/team'

FactoryBot.define do
  factory :team do
    transient do
      wins { 8 }
      division_wins { 2 }
      conference_wins { 2 }
      conf_not_div_wins { conference_wins - division_wins }
      non_conference_wins { wins - division_wins - conf_not_div_wins }
      teams_beat { [] }
    end
    name { "Jacksonville Jaguars" }
    conference { "AFC" }
    division { "AFC_SOUTH" }
    weighting { 1 }

    initialize_with { new(name, conference, division, weighting) }

    after(:build) do |team, evaluator|
      evaluator.division_wins.times { team.record_win(true, true) }
      evaluator.conf_not_div_wins.times { team.record_win(false, true) }
      evaluator.non_conference_wins.times { team.record_win(false, false) }
      if !evaluator.teams_beat.empty?
        evaluator.teams_beat.each { |t| team.teams_beat << t }
      end
    end
  end
end

#
# [#<Team:0x007fe61b2a51a8
#   @conference="NFC",
#   @conference_wins=9,
#   @division="NFC_NORTH",
#   @division_wins=5,
#   @name="Minnesota Vikings",
#   @teams_beat=
#    ["San Francisco 49ers", "Buffalo Bills", "Los Angeles Rams", "Arizona Cardinals", "New York Jets", "New Orleans Saints", "Detroit Lions", "Chicago Bears", "Green Bay Packers", "New England Patriots", "Detroit Lions", "Chicago Bears"],
#   @weighting=1,
#   @wins=12>,
#  #<Team:0x007fe61b2a5388
#   @conference="NFC",
#   @conference_wins=8,
#   @division="NFC_NORTH",
#   @division_wins=5,
#   @name="Green Bay Packers",
#   @teams_beat=["Chicago Bears", "Minnesota Vikings", "Washington Redskins", "Detroit Lions", "Los Angeles Rams", "New England Patriots", "Miami Dolphins", "Seattle Seahawks", "Chicago Bears", "Detroit Lions"],
#   @weighting=1,
#   @wins=10>,
#  #<Team:0x007fe61b2a5568
#   @conference="NFC",
#   @conference_wins=4,
#   @division="NFC_NORTH",
#   @division_wins=1,
#   @name="Chicago Bears",
#   @teams_beat=["Arizona Cardinals", "Miami Dolphins", "New York Jets", "Detroit Lions", "Los Angeles Rams", "San Francisco 49ers"],
#   @weighting=1,
#   @wins=6>,
