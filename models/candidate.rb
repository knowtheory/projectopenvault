class Candidate
  include DataMapper::Resource
  
  property :id, Serial
  property :name, String, :required => true
  property :incumbent, Boolean, :default => false
  property :url, String, :length => 2048, :format => :url
  
  has 1, :office
end
