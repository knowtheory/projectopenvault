class Office
  include DataMapper::Resource
  
  property :id,           Serial
  property :name,         String, :required => true, :length => 2048
  property :slug,         String, :required => true, :length => 2048
  property :title,        String
  property :abbreviation, String
  property :region,       String
  property :incumbent_id, Integer, :required => false
  
  has n, :buys
  has 1, :incumbent, "Candidate"
  has n, :candidates
  
  def name=(str)
    self.slug = Utilities.sluggify(str)
    super
  end

end
