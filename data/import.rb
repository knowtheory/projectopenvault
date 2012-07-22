require 'csv'

def most_recent_data_file
  here = File.dirname(__FILE__)
  pattern = /(\d{4})\.(\d{2})\.(\d{2})\.csv$/
  Dir.open(here).select{ |f| f =~ pattern }.sort_by{ |f| matches = f.match(pattern).to_a; matches.shift; matches.map(&:to_i) }.last
end

data = CSV.open(most_recent_data_file, :headers => true)

CSV.foreach(most_recent_data_file, :headers => true) do |row|

  buy        = Buy.new(pick row, %w(contract_id spots_per_week rate_per_spot start_time end_time start_date end_date))
  buy.submitter  = Submitter.first(:last_name => row.submitter)
  buy.station    = Station.first(:call_sign => row.station)
  buy.buyer      = Buyer.first_or_create(:name => row.buyer)
  buy.advertiser = Advertiser.first_or_create(:name => row.advertiser)
  if row.candidate =~ /Issue/i
    # ???
  else
    buy.candidate = Candidate.first(:name => row.candidate)
    buy.office    = Office.first(:name => row.race)
  end
  puts "Unable to save #{buy.inspect}" unless buy.save
end
