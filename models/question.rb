class Question
  include DataMapper::Resource
  
  property :id,               Serial
  property :prompt,           String, :length => 2048
  property :input_default,    String, :length => 2048
  property :form_url,         String, :length => 2048, :required => true, :format => :url
  property :form_markup,      Text,   :length => 4096, :required => true
  property :response_message, Text,   :length => 2048
  timestamps :at
end
