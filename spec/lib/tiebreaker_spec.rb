require "./lib/tiebreaker"

RSpec.describe Tiebreaker do
  subject { described_class.new }

  it "returns clear winner" do
    division = [
      build(:team, name: "Tennessee Titans"),
      build(:team, name: "Indianapolis Colts"),
      build(:team, name: "Houston Texans"),
      build(:team, name: "Jacksonville Jaguars", wins: 12)
    ]
    ranked = subject.rank_division(division)
    expect(ranked[0].name).to eq "Jacksonville Jaguars"
  end

  it "returns head to head winner" do
    division = [
      build(:team, name: "Jacksonville Jaguars", wins: 12),
      build(:team, name: "Tennessee Titans", wins: 12, teams_beat: ["Jacksonville Jaguars"]),
      build(:team, name: "Indianapolis Colts"),
      build(:team, name: "Houston Texans")
    ]
    ranked = subject.rank_division(division)
    expect(ranked[0].name).to eq "Tennessee Titans"
  end

  it "returns division_wins winner" do
    division = [
      build(:team, name: "Jacksonville Jaguars", wins: 12),
      build(:team, name: "Tennessee Titans"),
      build(:team, name: "Indianapolis Colts", wins: 12, division_wins: 5),
      build(:team, name: "Houston Texans")
    ]
    ranked = subject.rank_division(division)
    expect(ranked[0].name).to eq "Indianapolis Colts"
  end

  it "returns common_games winner" do
    NON_DIV_OPPONENTS ||= {
      "Jacksonville Jaguars" => ["Buffalo Bills"],
      "Houston Texans" => ["Buffalo Bills"],
      "Indianapolis Colts" => ["New England Patriots"],
      "Tennessee Titans" => ["New York Jets"]
    }

    division = [
      build(:team, name: "Jacksonville Jaguars", wins: 12),
      build(:team, name: "Tennessee Titans"),
      build(:team, name: "Indianapolis Colts"),
      build(:team, name: "Houston Texans", wins: 12, teams_beat: ["Buffalo Bills"])
    ]
    ranked = subject.rank_division(division)
    expect(ranked[0].name).to eq "Houston Texans"
  end

  it "returns conference_wins winner" do
    division = [
      build(:team, name: "Jacksonville Jaguars", wins: 12, conference_wins: 5),
      build(:team, name: "Tennessee Titans"),
      build(:team, name: "Indianapolis Colts", wins: 12),
      build(:team, name: "Houston Texans")
    ]
    ranked = subject.rank_division(division)
    expect(ranked[0].name).to eq "Jacksonville Jaguars"
  end

  it "returns multiway head to head winner" do
    division = [
      build(:team, name: "Jacksonville Jaguars", wins: 9, teams_beat: ["Tennessee Titans"]),
      build(:team, name: "Tennessee Titans", wins: 9, teams_beat: ["Jacksonville Jaguars", "Indianapolis Colts"]),
      build(:team, name: "Indianapolis Colts", wins: 9, teams_beat: ["Tennessee Titans"]),
      build(:team, name: "Houston Texans")
    ]
    ranked = subject.rank_division(division)
    expect(ranked[0].name).to eq "Tennessee Titans"
  end

end
