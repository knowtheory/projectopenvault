# require './config/models.rb'; DataMapper.auto_migrate!; load './data/fixtures.rb'; load './data/import.rb'
require File.join(File.dirname(__FILE__),'..','config','models.rb')
DataMapper.auto_upgrade!

def drop(resource)
  DataMapper.repository.adapter.execute("drop table #{resource.storage_name} cascade")
end

#[Buy, Buyer, Committee, Ad, Office, Candidate, User, Station].each{ |resource| drop resource and resource.auto_migrate! }

Buy.auto_migrate!

#load File.join(File.dirname(__FILE__),'fixtures.rb') # ensures that all the background data exists.
require 'csv'
#require './config/models.rb'; DataMapper.auto_migrate!
def most_recent_data_file(name,dir=nil)
  path = dir || File.dirname(__FILE__)
  pattern = /^#{name}\.(\d{4})\.(\d{2})\.(\d{2})\.csv$/
  File.join path, Dir.open(path).select{ |f| f =~ pattern }.sort_by{ |f| matches = f.match(pattern).to_a; matches.shift; matches.map(&:to_i) }.last
end

#CSV.foreach(most_recent_data_file('offices'), :headers => true) do |row|
#  office = Office.new(Utilities.pick row, *%w(name title abbreviation region))
#  if office.save
#    puts "#{Time.now}: saved office #{office.id}"
#  else
#    puts "#{Time.now}: Unable to save #{office.errors.inspect}"
#  end  
#end
#

rows.reject{ |row| Committee.first(:name => row["name"]) }
CSV.foreach(most_recent_data_file('committees'), :headers => true) do |row|
  unless Committee.first(:name => row["name"])
    committee = Committee.new(Utilities.pick row, *%w(name url description))
    if row['type']
      if row['type'] =~ /Candidate/i
        committee.type = :candidate
      elsif row['type'] =~ /Party/i
        committee.type = :party
      elsif row['type'] =~ /501\(c\)\(4\)/i
        committee.type = :five_oh_one_c_four
      elsif row['type'] =~ /527/i
        committee.type = :five_twenty_seven
      elsif row['type'] =~ /Independent/i
        committee.type = :independent
      else
        committee.type = :not_applicable
      end
    else
      committee.type = :not_applicable
    end
  
    puts committee.save ? "#{Time.now}: saved Committee #{committee.id}" : "#{Time.now}: Unable to save #{committee.errors.inspect}"
  else
    puts "#{row["name"]} exists."
  end
end

f = 'candidates'; data = CSV.open(most_recent_data_file(f,'./data'), :headers => true).read; row = data.first
CSV.foreach(most_recent_data_file('candidates'), :headers => true) do |row|
  unless Candidate.first(:name => row['candidate'])
    candidate = Candidate.new(Utilities.pick row, *%w(party, url))
    candidate.name = row['candidate'].strip

    if row['current_office']
      current_office = Office.first_or_new(:name   => row['current_office'].strip,
                                           :region => row['region_current_office'].strip)
      current_office.title = row['title'].strip               unless current_office.title
      current_office.abbreviation = row['abbreviation'].strip unless current_office.abbreviation
    
      if current_office.save
        puts "#{Time.now}: saved office #{current_office.id}"
        candidate.incumbency = current_office
      else
        puts "#{Time.now}: Unable to save #{current_office.errors.inspect}"
      end
    end
  
    unless row['office_sought'].nil? or row['region_office_sought'].nil?
      running_for = Office.first_or_new(:name => row['office_sought'].strip, :region => row['region_office_sought'].strip)
      puts running_for.save ? "#{Time.now}: saved office #{running_for.id}" : "#{Time.now}: Unable to save #{running_for.errors.inspect}"
      candidate.office = running_for
    end
  
    puts candidate.save ? "#{Time.now}: saved Candidate #{candidate.id}" : "#{Time.now}: Unable to save #{candidate.errors.inspect}"
  else
    puts "#{row['candidate']} already exists."
  end
end

CSV.foreach(most_recent_data_file('advault_data'), :headers => true) do |row|

  start_date = Date.strptime row['start_date'], '%m/%d/%Y'
  end_date   = Date.strptime row['end_date'], '%m/%d/%Y'

  buy               = Buy.new(Utilities.pick row, *%w(contract_id spots_per_week rate_per_spot start_time end_time election length))
  buy.start_time    = (row['start_time'] || '').strip
  buy.end_time      = (row['end_time'] || '').strip
  buy.start_date    = start_date
  buy.end_date      = end_date
  buy.total_cost    = buy.rate_per_spot * buy.spots_per_week
  buy.total_runtime = buy.length * buy.spots_per_week
  buy.submitter     = User.first :last_name => row['submitter'].strip
  buy.station       = Station.first :call_sign => row['station'].strip
  buy.buyer         = Buyer.first_or_create :name => row['buyer'].strip
  buy.committee     = Committee.first_or_create :name => row['advertiser'].strip
  buy.cancelled     = !!row['cancelled'].match(/yes/i)

  if row['candidate'] !~ /Issue/i
    buy.candidate = Candidate.first(:name => row['candidate'].strip) if row['candidate']
    buy.office    = Office.first(:name => row['office'].strip, :region => row['region'].strip) if row['office'] and row['region']
  else
    # ???
  end

  puts buy.save ? "#{Time.now}: saved #{buy.id}" : "#{Time.now}: Unable to save #{buy.errors.inspect}" 
end
