module NFL

  NON_DIV_OPPONENTS = {
    "Arizona Cardinals"=>["Washington Redskins", "Chicago Bears", "Denver Broncos", "Oakland Raiders", "Detroit Lions", "Minnesota Vikings", "Kansas City Chiefs", "Los Angeles Chargers", "Green Bay Packers", "Atlanta Falcons"],
    "Atlanta Falcons"=>["Cincinnati Bengals", "New York Giants", "Dallas Cowboys", "Baltimore Ravens", "Arizona Cardinals", "Philadelphia Eagles", "Pittsburgh Steelers", "Washington Redskins", "Cleveland Browns", "Green Bay Packers"],
    "Baltimore Ravens"=>["Buffalo Bills", "Denver Broncos", "New Orleans Saints", "Oakland Raiders", "Tampa Bay Buccaneers", "Tennessee Titans", "Carolina Panthers", "Atlanta Falcons", "Kansas City Chiefs", "Los Angeles Chargers"],
    "Buffalo Bills"=>["Los Angeles Chargers", "Tennessee Titans", "Chicago Bears", "Jacksonville Jaguars", "Detroit Lions", "Baltimore Ravens", "Minnesota Vikings", "Green Bay Packers", "Houston Texans", "Indianapolis Colts"],
    "Carolina Panthers"=>["Dallas Cowboys", "Cincinnati Bengals", "New York Giants", "Baltimore Ravens", "Seattle Seahawks", "Washington Redskins", "Philadelphia Eagles", "Pittsburgh Steelers", "Detroit Lions", "Cleveland Browns"],
    "Chicago Bears"=>["Seattle Seahawks", "Tampa Bay Buccaneers", "New England Patriots", "New York Jets", "Los Angeles Rams", "Arizona Cardinals", "Miami Dolphins", "Buffalo Bills", "New York Giants", "San Francisco 49ers"],
    "Cincinnati Bengals"=>["Miami Dolphins", "Tampa Bay Buccaneers", "New Orleans Saints", "Denver Broncos", "Oakland Raiders", "Indianapolis Colts", "Carolina Panthers", "Atlanta Falcons", "Kansas City Chiefs", "Los Angeles Chargers"],
    "Cleveland Browns"=>["New York Jets", "Los Angeles Chargers", "Kansas City Chiefs", "Atlanta Falcons", "Carolina Panthers", "New Orleans Saints", "Oakland Raiders", "Tampa Bay Buccaneers", "Houston Texans", "Denver Broncos"],
    "Dallas Cowboys"=>["Detroit Lions", "Jacksonville Jaguars", "Tennessee Titans", "New Orleans Saints", "Tampa Bay Buccaneers", "Carolina Panthers", "Seattle Seahawks", "Houston Texans", "Atlanta Falcons", "Indianapolis Colts"],
    "Denver Broncos"=>["Seattle Seahawks", "Los Angeles Rams", "Houston Texans", "Pittsburgh Steelers", "Cleveland Browns", "Baltimore Ravens", "New York Jets", "Arizona Cardinals", "Cincinnati Bengals", "San Francisco 49ers"],
    "Detroit Lions"=>["New York Jets", "New England Patriots", "Seattle Seahawks", "Carolina Panthers", "Los Angeles Rams", "San Francisco 49ers", "Dallas Cowboys", "Miami Dolphins", "Arizona Cardinals", "Buffalo Bills"],
    "Green Bay Packers"=>["Buffalo Bills", "San Francisco 49ers", "Miami Dolphins", "Arizona Cardinals", "Atlanta Falcons", "Washington Redskins", "Los Angeles Rams", "New England Patriots", "Seattle Seahawks", "New York Jets"],
    "Houston Texans"=>["New York Giants", "Dallas Cowboys", "Buffalo Bills", "Miami Dolphins", "Cleveland Browns", "New England Patriots", "Denver Broncos", "Washington Redskins", "New York Jets", "Philadelphia Eagles"],
    "Indianapolis Colts"=>["Cincinnati Bengals", "Buffalo Bills", "Miami Dolphins", "Dallas Cowboys", "New York Giants", "Washington Redskins", "Philadelphia Eagles", "New England Patriots", "New York Jets", "Oakland Raiders"],
    "Jacksonville Jaguars"=>["New England Patriots", "New York Jets", "Philadelphia Eagles", "Pittsburgh Steelers", "Washington Redskins", "New York Giants", "Kansas City Chiefs", "Dallas Cowboys", "Buffalo Bills", "Miami Dolphins"],
    "Kansas City Chiefs"=>["San Francisco 49ers", "Jacksonville Jaguars", "Cincinnati Bengals", "Arizona Cardinals", "Baltimore Ravens", "Pittsburgh Steelers", "New England Patriots", "Cleveland Browns", "Los Angeles Rams", "Seattle Seahawks"],
    "Miami Dolphins"=>["Tennessee Titans", "Oakland Raiders", "Chicago Bears", "Detroit Lions", "Jacksonville Jaguars", "Cincinnati Bengals", "Houston Texans", "Green Bay Packers", "Indianapolis Colts", "Minnesota Vikings"],
    "Minnesota Vikings"=>["San Francisco 49ers", "Buffalo Bills", "Arizona Cardinals", "New Orleans Saints", "Miami Dolphins", "Los Angeles Rams", "Philadelphia Eagles", "New York Jets", "New England Patriots", "Seattle Seahawks"],
    "New England Patriots"=>["Houston Texans", "Indianapolis Colts", "Kansas City Chiefs", "Green Bay Packers", "Minnesota Vikings", "Jacksonville Jaguars", "Detroit Lions", "Chicago Bears", "Tennessee Titans", "Pittsburgh Steelers"],
    "New Orleans Saints"=>["Cleveland Browns", "Washington Redskins", "Los Angeles Rams", "Philadelphia Eagles", "Pittsburgh Steelers", "New York Giants", "Baltimore Ravens", "Minnesota Vikings", "Cincinnati Bengals", "Dallas Cowboys"],
    "New York Giants"=>["Jacksonville Jaguars", "New Orleans Saints", "Tampa Bay Buccaneers", "Chicago Bears", "Tennessee Titans", "Houston Texans", "Carolina Panthers", "Atlanta Falcons", "San Francisco 49ers", "Indianapolis Colts"],
    "New York Jets"=>["Denver Broncos", "Indianapolis Colts", "Minnesota Vikings", "Houston Texans", "Green Bay Packers", "Detroit Lions", "Cleveland Browns", "Jacksonville Jaguars", "Chicago Bears", "Tennessee Titans"],
    "Oakland Raiders"=>["Los Angeles Rams", "Cleveland Browns", "Seattle Seahawks", "Indianapolis Colts", "Pittsburgh Steelers", "Miami Dolphins", "San Francisco 49ers", "Arizona Cardinals", "Baltimore Ravens", "Cincinnati Bengals"],
    "Philadelphia Eagles"=>["Atlanta Falcons", "Indianapolis Colts", "Minnesota Vikings", "Carolina Panthers", "Houston Texans", "Tampa Bay Buccaneers", "Tennessee Titans", "Jacksonville Jaguars", "New Orleans Saints", "Los Angeles Rams"],
    "Pittsburgh Steelers"=>["Kansas City Chiefs", "Atlanta Falcons", "Carolina Panthers", "Los Angeles Chargers", "New England Patriots", "Tampa Bay Buccaneers", "Jacksonville Jaguars", "Denver Broncos", "Oakland Raiders", "New Orleans Saints"],
    "Los Angeles Rams"=>["Los Angeles Chargers", "Minnesota Vikings", "Green Bay Packers", "Kansas City Chiefs", "Philadelphia Eagles", "Oakland Raiders", "Denver Broncos", "New Orleans Saints", "Detroit Lions", "Chicago Bears"],
    "Los Angeles Chargers"=>["San Francisco 49ers", "Tennessee Titans", "Arizona Cardinals", "Cincinnati Bengals", "Baltimore Ravens", "Buffalo Bills", "Los Angeles Rams", "Cleveland Browns", "Seattle Seahawks", "Pittsburgh Steelers"],
    "San Francisco 49ers"=>["Detroit Lions", "Oakland Raiders", "New York Giants", "Denver Broncos", "Chicago Bears", "Minnesota Vikings", "Kansas City Chiefs", "Los Angeles Chargers", "Green Bay Packers", "Tampa Bay Buccaneers"],
    "Seattle Seahawks"=>["Dallas Cowboys", "Los Angeles Chargers", "Green Bay Packers", "Minnesota Vikings", "Kansas City Chiefs", "Denver Broncos", "Chicago Bears", "Oakland Raiders", "Detroit Lions", "Carolina Panthers"],
    "Tampa Bay Buccaneers"=>["Philadelphia Eagles", "Pittsburgh Steelers", "Cleveland Browns", "Washington Redskins", "San Francisco 49ers", "Chicago Bears", "Cincinnati Bengals", "New York Giants", "Baltimore Ravens", "Dallas Cowboys"],
    "Tennessee Titans"=>["Philadelphia Eagles", "Baltimore Ravens", "New England Patriots", "New York Jets", "Washington Redskins", "Miami Dolphins", "Buffalo Bills", "Los Angeles Chargers", "Dallas Cowboys", "New York Giants"],
    "Washington Redskins"=>["Indianapolis Colts", "Green Bay Packers", "Carolina Panthers", "Atlanta Falcons", "Houston Texans", "Arizona Cardinals", "New Orleans Saints", "Tampa Bay Buccaneers", "Jacksonville Jaguars", "Tennessee Titans"]
   }
end

 # hash = {}
 #
 # NFL::TEAMS.map do |team|
 #
 #   home_opponents = FIXTURES.select {|f| f[:home] == team[:name]}.map {|f| f[:away] }
 #   away_opponents = FIXTURES.select {|f| f[:away] == team[:name]}.map {|f| f[:home] }
 #   opponents = home_opponents + away_opponents
 #   non_div = opponents.select do |opp|
 #
 #   opp_team = NFL::TEAMS.find {|h| h[:name] == opp}
 #     opp_team[:division] != team[:division]
 #   end
 #   hash[team[:name]] = non_div
 # end
