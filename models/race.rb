class Race
  include DataMapper::Resource
  
  property :id, Serial
  property :office, String, :required => true
end