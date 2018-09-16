require "./lib/tiebreakers/playoff_seeder"

RSpec.describe PlayoffSeeder do
  subject { described_class }

  it "returns teams with no ties" do
    division_winners = [
      build(:team, name: "Pittsburgh Steelers", division: "AFC_NORTH", wins: 13),
      build(:team, name: "Jacksonville Jaguars", wins: 12),
      build(:team, name: "New England Patriots", division: "AFC_EAST", wins: 11 ),
      build(:team, name: "Kansas City Chiefs", division: "AFC_WEST", wins: 10)
    ]
    ranked = subject.division_winners(division_winners)
    expect(ranked[0].name).to eq "Pittsburgh Steelers"
    expect(ranked[1].name).to eq "Jacksonville Jaguars"
    expect(ranked[2].name).to eq "New England Patriots"
    expect(ranked[3].name).to eq "Kansas City Chiefs"
  end

  it "returns teams with single ties" do
    division_winners = [
      build(:team, name: "Pittsburgh Steelers", division: "AFC_NORTH", wins: 12),
      build(:team, name: "Jacksonville Jaguars", wins: 12, teams_beat: ["Pittsburgh Steelers"]),
      build(:team, name: "New England Patriots", division: "AFC_EAST", wins: 11, conference_wins: 4 ),
      build(:team, name: "Kansas City Chiefs", division: "AFC_WEST", wins: 11)
    ]
    ranked = subject.division_winners(division_winners)
    expect(ranked[0].name).to eq "Jacksonville Jaguars"
    expect(ranked[1].name).to eq "Pittsburgh Steelers"
    expect(ranked[2].name).to eq "New England Patriots"
    expect(ranked[3].name).to eq "Kansas City Chiefs"
  end

  it "returns teams with multiple ties" do
    division_winners = [
      build(:team, name: "Pittsburgh Steelers", division: "AFC_NORTH", wins: 12),
      build(:team, name: "Jacksonville Jaguars", wins: 12, teams_beat: ["Pittsburgh Steelers"], conference_wins: 5),
      build(:team, name: "New England Patriots", division: "AFC_EAST", wins: 12, conference_wins: 4 ),
      build(:team, name: "Kansas City Chiefs", division: "AFC_WEST", wins: 12, teams_beat: ["Pittsburgh Steelers"])
    ]
    ranked = subject.division_winners(division_winners)
    expect(ranked[0].name).to eq "Jacksonville Jaguars"
    expect(ranked[1].name).to eq "Kansas City Chiefs"
    expect(ranked[2].name).to eq "New England Patriots"
    expect(ranked[3].name).to eq "Pittsburgh Steelers"
  end

  it "returns wildcards" do
    wildcard_teams = [
      build(:team, name: "Pittsburgh Steelers", division: "AFC_NORTH", wins: 12),
      build(:team, name: "Jacksonville Jaguars", wins: 12, teams_beat: ["Pittsburgh Steelers"], conference_wins: 5),
      build(:team, name: "New England Patriots", division: "AFC_EAST", wins: 12, conference_wins: 4 ),
      build(:team, name: "Kansas City Chiefs", division: "AFC_WEST", wins: 12, teams_beat: ["Pittsburgh Steelers"])
    ]
    wildcards = subject.wildcards(wildcard_teams)
    expect(wildcards.first.name).to eq "Jacksonville Jaguars"
    expect(wildcards.last.name).to eq "Kansas City Chiefs"
    expect(wildcards.count).to eq 2
  end
end
