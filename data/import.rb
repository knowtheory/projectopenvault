require File.join(File.dirname(__FILE__),'..','config','setup.rb')
require 'csv'

def most_recent_data_file(dir=nil)
  path = dir || File.dirname(__FILE__)
  pattern = /(\d{4})\.(\d{2})\.(\d{2})\.csv$/
  File.join path, Dir.open(path).select{ |f| f =~ pattern }.sort_by{ |f| matches = f.match(pattern).to_a; matches.shift; matches.map(&:to_i) }.last
end

#data = CSV.open(most_recent_data_file('./data'), :headers => true).read

CSV.foreach(most_recent_data_file, :headers => true) do |row|

  start_date = Date.strptime row['start_date'], '%m/%d/%Y'
  end_date   = Date.strptime row['end_date'], '%m/%d/%Y'
  attrs      = pick( row, *%w(contract_id spots_per_week rate_per_spot start_time end_time))
  attrs.merge!("start_time" => start_date, "end_time" => end_date )
  unless buy = Buy.first(attrs)
    buy            = Buy.new(pick row, *%w(contract_id spots_per_week rate_per_spot start_time end_time election_cycle))
    buy.start_date = start_date
    buy.end_date   = end_date
    buy.submitter  = User.first :last_name => row['submitter']
    buy.station    = Station.first :call_sign => row['station']
    buy.buyer      = Buyer.first_or_create :name => row['buyer']
    buy.advertiser = Advertiser.first_or_create :name => row['advertiser']

    if row['candidate'] !~ /Issue/i
      buy.candidate = Candidate.first(:name => row['candidate'])
      buy.office    = Office.first(:name => row['office'])
    else
      # ???
    end

    puts buy.save ? "#{Time.now}: saved #{buy.id}" : "#{Time.now}: Unable to save #{buy.errors.inspect}" 
  else
    puts "Skipping #{buy.id}"
  end
end
