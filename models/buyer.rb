class Buyer
  include DataMapper::Resource
  
  property :id, Serial
  property :name, String, :required => true
  property :url, String, :length => 2048, :format => :url
end
