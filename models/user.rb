class User
  include DataMapper::Resource
  
  property :id,              Serial
  property :first_name,      String
  property :last_name,       String
  property :email,           String
  property :hashed_password, String
end