class Office
  include DataMapper::Resource
  
  property :id,           Serial
  property :name,         String, :required => true, :length => 2048
  property :slug,         String, :required => true, :length => 2048, :unique => true
  property :title,        String
  property :abbreviation, String
  property :region,       String
  
  has n, :buys
  belongs_to :incumbent, "Candidate", :child_key => [:candidate_id], :required => false
  
  def name=(str)
    self.slug = Utilities.sluggify(str)
    super
  end

end
