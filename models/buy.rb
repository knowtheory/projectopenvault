class Buy
  include DataMapper::Resource
  
  property :id,             Serial
  property :contract_id,    Integer, :required => true
  property :start_time,     String
  property :end_time,       String
  property :start_date,     Date
  property :end_date,       Date
  property :spots_per_week, Integer
  property :rate_per_spot,  Integer
  property :total_cost,     Integer
  property :election,       Enum[:primary, :general, :issue]
  property :length,         Integer
  property :total_runtime,  Integer
  property :cancelled,      Boolean, :default => false, :required => true
  
  belongs_to :submitter, :model => "User"
  belongs_to :station
  belongs_to :buyer
  belongs_to :committee
  belongs_to :candidate, :required => false
  belongs_to :office,    :required => false

  def self.fulfilled(conditions={})
    defaults = { "end_date.lte" => Time.now, "cancelled" => false}
    all defaults.merge(conditions)
  end
  
  def canonical(options = {})
    rep = {
      'id'              => self.id,
      'contract_id'     => self.contract_id,
      'start_time'      => self.start_time,
      'end_time'        => self.end_time,
      'start_date'      => self.start_date.to_s,
      'end_date'        => self.end_date.to_s,
      'spots_per_week'  => self.spots_per_week,
      'rate_per_spot'   => self.rate_per_spot,
      'total_cost'      => self.total_cost,
      'election'        => self.election,
      'length'          => self.length,
      'total_runtime'   => self.total_runtime,
      'candidate_id'    => self.candidate_id,
      'station'         => self.station.call_sign,
      'committee'       => self.committee.name
    }
    rep
  end
end
