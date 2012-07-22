class Ad
  include DataMapper::Resource
  
  property :id, Serial
  property :name, String, :required => true
  property :url, String, :length => 2048, :format => :url
  property :embed_code, Text
  property :description, Text
  property :script, Text
end