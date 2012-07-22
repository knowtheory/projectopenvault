class Office
  include DataMapper::Resource
  
  property :id, Serial
  property :name, String, :required => true, :length => 2048
  property :title, String
  property :abbreviation, String
  property :region, String
  
  belongs_to :incumbent, "Candidate", :child_key => [:candidate_id], :required => false
end
