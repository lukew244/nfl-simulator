module NFL

  DIVISIONS = {
    AFC_EAST: [],
    AFC_WEST: [],
    AFC_NORTH: [],
    AFC_SOUTH: [],
    NFC_EAST: [],
    NFC_WEST: [],
    NFC_NORTH: [],
    NFC_SOUTH: []
  }

  AFC, NFC = DIVISIONS.partition.with_index { |_, index| index <= 3 }

  TEAMS = [
    {:name=>"Arizona Cardinals", :weighting=>1, :conference=>"NFC", :division=>"NFC_WEST"},
    {:name=>"Atlanta Falcons", :weighting=>1, :conference=>"NFC", :division=>"NFC_SOUTH"},
    {:name=>"Baltimore Ravens", :weighting=>1, :conference=>"AFC", :division=>"AFC_NORTH"},
    {:name=>"Buffalo Bills", :weighting=>1, :conference=>"AFC", :division=>"AFC_EAST"},
    {:name=>"Carolina Panthers", :weighting=>1, :conference=>"NFC", :division=>"NFC_SOUTH"},
    {:name=>"Chicago Bears", :weighting=>1, :conference=>"NFC", :division=>"NFC_NORTH"},
    {:name=>"Cincinnati Bengals", :weighting=>1, :conference=>"AFC", :division=>"AFC_NORTH"},
    {:name=>"Cleveland Browns", :weighting=>1, :conference=>"AFC", :division=>"AFC_NORTH"},
    {:name=>"Dallas Cowboys", :weighting=>1, :conference=>"NFC", :division=>"NFC_EAST"},
    {:name=>"Denver Broncos", :weighting=>1, :conference=>"AFC", :division=>"AFC_WEST"},
    {:name=>"Detroit Lions", :weighting=>1, :conference=>"NFC", :division=>"NFC_NORTH"},
    {:name=>"Green Bay Packers", :weighting=>1, :conference=>"NFC", :division=>"NFC_NORTH"},
    {:name=>"Houston Texans", :weighting=>1, :conference=>"AFC", :division=>"AFC_SOUTH"},
    {:name=>"Indianapolis Colts", :weighting=>1, :conference=>"AFC", :division=>"AFC_SOUTH"},
    {:name=>"Jacksonville Jaguars", :weighting=>1, :conference=>"AFC", :division=>"AFC_SOUTH"},
    {:name=>"Kansas City Chiefs", :weighting=>1, :conference=>"AFC", :division=>"AFC_WEST"},
    {:name=>"Miami Dolphins", :weighting=>1, :conference=>"AFC", :division=>"AFC_EAST"},
    {:name=>"Minnesota Vikings", :weighting=>1, :conference=>"NFC", :division=>"NFC_NORTH"},
    {:name=>"New England Patriots", :weighting=>1, :conference=>"AFC", :division=>"AFC_EAST"},
    {:name=>"New Orleans Saints", :weighting=>1, :conference=>"NFC", :division=>"NFC_SOUTH"},
    {:name=>"New York Giants", :weighting=>1, :conference=>"NFC", :division=>"NFC_EAST"},
    {:name=>"New York Jets", :weighting=>1, :conference=>"AFC", :division=>"AFC_EAST"},
    {:name=>"Oakland Raiders", :weighting=>1, :conference=>"AFC", :division=>"AFC_WEST"},
    {:name=>"Philadelphia Eagles", :weighting=>1, :conference=>"NFC", :division=>"NFC_EAST"},
    {:name=>"Pittsburgh Steelers", :weighting=>1, :conference=>"AFC", :division=>"AFC_NORTH"},
    {:name=>"Los Angeles Rams", :weighting=>1, :conference=>"NFC", :division=>"NFC_WEST"},
    {:name=>"Los Angeles Chargers", :weighting=>1, :conference=>"AFC", :division=>"AFC_WEST"},
    {:name=>"San Francisco 49ers", :weighting=>1, :conference=>"NFC", :division=>"NFC_WEST"},
    {:name=>"Seattle Seahawks", :weighting=>1, :conference=>"NFC", :division=>"NFC_WEST"},
    {:name=>"Tampa Bay Buccaneers", :weighting=>1, :conference=>"NFC", :division=>"NFC_SOUTH"},
    {:name=>"Tennessee Titans", :weighting=>1, :conference=>"AFC", :division=>"AFC_SOUTH"},
    {:name=>"Washington Redskins", :weighting=>1, :conference=>"NFC", :division=>"NFC_EAST"}
  ]
end
