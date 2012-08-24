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
  
  #def name=(str)
  #  self.slug = Utilities.sluggify(str)
  #  super
  #end
  
  before :valid?, :ensure_slug
  
  def ensure_slug
    self.slug = Utilities.sluggify("#{name} #{region}") unless self.slug
  end
  
  def canonical(options={})
    rep = {
      'name' => self.name,
      'slug' => self.slug,
      'title' => self.title,
      'abbreviation' => self.abbreviation,
      'region' => self.region
    }
    rep['incumbent'] = self.incumbent.name if self.incumbent
    rep['buys'] = self.buys.map(&:canonical) if options[:buys]
    rep
  end
end

# U.S. Rep. District 4
# State Rep. District 47
# 