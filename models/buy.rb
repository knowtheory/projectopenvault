class Buy
  include DataMapper::Resource
  
  property :id, Serial
  property :contract_id, Integer, :required => true
  property :start_time, String
  property :end_time, String
  property :start_date, Date
  property :end_date, Date
  property :spots_per_week, Integer
  property :rate_per_spot, Integer
  property :election_cycle, Enum[:primary, :general, :issue]
  
  belongs_to :submitter, :model => "User"
  belongs_to :station
  belongs_to :buyer
  belongs_to :advertiser
  belongs_to :candidate, :required => false
  belongs_to :office, :required => false
end
