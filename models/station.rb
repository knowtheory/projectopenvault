class Station
  include DataMapper::Resource
  
  property :id, Serial
  property :name, String, :required => true
  property :call_sign, String, :required => true
end