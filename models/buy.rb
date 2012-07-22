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
  property :total,          Integer
  property :election, Enum[:primary, :general, :issue]
  
  belongs_to :submitter, :model => "User"
  belongs_to :station
  belongs_to :buyer
  belongs_to :advertiser
  belongs_to :candidate, :required => false
  belongs_to :office,    :required => false
  
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
      'total'           => self.total,
      'election'        => self.election,
    }
    rep
  end
end
