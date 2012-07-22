[
  ["Peter Kinder", true], 
  ["Brad Lager", true], 
  ["John Brunner"], 
  ["Sarah Steelman"], 
  ["Todd Akin", true], 
  ["Claire McCaskill", true], 
  ["Dave Spence"],
  ["Jay Nixon", true]
].each{ |candidate| Candidate.create Hash[[:name, :incumbent].zip(candidate)] }

[
  ["Lieutenant Governor", "Lieutenant Governor", "Lt. Gov.", "State-wide", "Peter Kinder"],
  ["U.S. Senate", "Senator", "Sen.", "State-wide", "Claire McCaskill"],
  ["Governor", "Governor", "Gov.", "State-wide", "Jay Nixon"],
  ["Missouri Senate from the 12th District", "State Senator", "St. Sen.", "12th District", "Brad Lager"],
  ["U.S. Representative from the 2nd District", "Representative",  "Rep.", "2nd District", "Todd Akin"]
].each do |data|
  data.push Candidate.first(:name=>data.pop) if data.size > 4
  Office.create Hash[[:name, :title, :abbreviation, :region, :incumbent].zip(data)]
end

[
  ["KRCG-TV", "KRCG", "http://www.connectmidmissouri.com/"],
  ["KOMU-TV", "KOMU", "http://www.komu.com/home/"],
  ["J.W. Broadcasting", "KMIZ", "http://www.kmiz.com/"],
  ["J.W. Broadcasting", "KQFX"]
].each{ |station| Station.create Hash[[:name, :call_sign, :url].zip(station)] }

[
  ["Ted", "Han", "ted@knowtheory.net"],
  ["Matthew", "Patane", "patane.mf@gmail.com"],
  ["David", "Herzog", "herzogd@rjionline.org"]
].each{ |user| User.create Hash[[:first_name, :last_name, :email].zip(user)] }

