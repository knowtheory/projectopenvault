class Committee
  include DataMapper::Resource
  COMMITTEE_TYPE = {
    :candidate => "candidate", 
    :party => "party", 
    :five_oh_one_c_four => "501(c)(4)", 
    :five_twenty_seven => "527", 
    :independent => "independent", 
    :not_applicable => "not applicable"
  }
  
  property :id,   Serial
  property :name, String, :required => true, :length => 2048
  property :slug, String, :length => 2048
  property :type, Enum[:candidate, :party, :five_oh_one_c_four, :five_twenty_seven, :independent, :not_applicable], :default => :not_applicable
  property :description, Text
  property :url,  String, :length => 2048, :format => :url
  
  has n, :buys
  has n, :ads

  def name=(str)
    self.slug = Utilities.sluggify(str)
    super
  end
  
  def canonical(options={})
    rep = {
      'name' => self.name,
      'slug' => self.slug,
      'type' => self.type,
      'description' => self.description,
      'url' => self.url,
    }

    buys = Buy.all(:committee_id => self.id).fulfilled
    rep['total_spent'] = buys.sum(:total_cost) || 0
    rep['buys'] = buys.map(&:canonical) if options[:buys]
    rep
  end
end
