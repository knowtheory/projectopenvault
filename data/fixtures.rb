[
  ["Lieutenant Governor", "Lieutenant Governor", "Lt. Gov.", "State-wide"],
  ["U.S. Senate", "Senator", "Sen.", "State-wide"],
  ["Governor", "Governor", "Gov.", "State-wide"]
].each{ |office| Office.create Hash[[:name, :title, :abbreviation, :region].zip(office)] }

[
  ["KRCG-TV", "KRCG", "http://www.connectmidmissouri.com/"],
  ["KOMU-TV", "KOMU", "http://www.komu.com/home/"],
  ["J.W. Broadcasting", "KMIZ", "http://www.kmiz.com/"]
].each{ |station| Station.create Hash[[:name, :call_sign, :url].zip(station)] }

[
  ["Ted", "Han", "ted@knowtheory.net"],
  ["Matthew", "Patane", "patane.mf@gmail.com"],
  ["David", "Herzog", "herzogd@rjionline.org"]
].each{ |user| User.create Hash[[:first_name, :last_name, :email].zip(user)] }
