class Committee
  include DataMapper::Resource
  
  property :id,   Serial
  property :name, String, :required => true
  property :slug, String, :length => 2048
  property :url,  String, :length => 2048, :format => :url
  property :tax_status, Enum[:five_oh_one_c_four, :five_oh_one_c_six, :super_pac]
  
  has n, :buys

  def name=(str)
    self.slug = Utilities.sluggify(str)
    super
  end
end
