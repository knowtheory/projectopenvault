class Committee
  include DataMapper::Resource
  
  property :id,   Serial
  property :name, String, :required => true
  property :slug, String, :length => 2048
  property :type, String
  property :description, Text
  property :url,  String, :length => 2048, :format => :url
  #property :tax_status, Enum[:five_oh_one_c_four, :five_oh_one_c_six, :super_pac]
  
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

    conditions = { "end_date.lte" => (options["end_date"] || Time.now) }
    buys = Buy.all conditions
    rep['total_spent'] = buys.sum(:total_cost, :committee_id => self.id) || 0
    rep['buys'] = buys.map(&:canonical) if options[:buys]
    rep
  end
end
