[
  ["Lieutenant Governor", "Lieutenant Governor", "Lt. Gov.", "State-wide"],
  ["U.S. Senate", "Senator", "Sen.", "State-wide"],
  ["Governor", "Governor", "Gov.", "State-wide"]
].each{ |office| Office.create Hash[[:name, :title, :abbreviation, :region].zip(office)] }

[
  ["KRCG-TV", "KRCG", ""],
  ["KOMU-TV", "KOMU", ""],
  ["J.W. Broadcasting", "KMIZ", ""]
].each{ |station| Station.create Hash[[:name, :call_sign, :url].zip(station)] }