#[
#  ["Peter Kinder", true], 
#  ["Brad Lager", true], 
#  ["John Brunner"], 
#  ["Sarah Steelman"], 
#  ["Todd Akin", true], 
#  ["Claire McCaskill", true], 
#  ["Dave Spence"],
#  ["Jay Nixon", true]
#].each{ |candidate| Candidate.first_or_create Hash[[:name, :incumbent].zip(candidate)] }
#
[
  ["County Sheriff", "Sheriff", "Sheriff", "Osage County"]
].each do |data|
  Office.first_or_create Hash[[:name, :title, :abbreviation, :region].zip(data)]
end



[
  ["KRCG-TV", "KRCG", "http://www.connectmidmissouri.com/"],
  ["KOMU-TV", "KOMU", "http://www.komu.com/home/"],
  ["J.W. Broadcasting", "KMIZ", "http://www.kmiz.com/"],
  ["J.W. Broadcasting", "KQFX"],
  ["The CW", "KOMU-CW"]
].each{ |station| Station.first_or_create Hash[[:name, :call_sign, :url].zip(station)] }

[
  ["Ted", "Han", "ted@knowtheory.net"],
  ["Matthew", "Patane", "patane.mf@gmail.com"],
  ["David", "Herzog", "herzogd@rjionline.org"]
].each{ |user| User.first_or_create Hash[[:first_name, :last_name, :email].zip(user)] }

