class Candidate
  include DataMapper::Resource
  
  property :id, Serial
  property :name, String, :required => true
  property :incumbent, Boolean, :default => false
end