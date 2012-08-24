class Candidate
  include DataMapper::Resource
  
  property :id,        Serial
  property :name,      String, :required => true
  property :slug,      String, :required => true, :length => 2048, :unique => true
  property :party,     String
  property :incumbent, Boolean, :default => false
  property :url,       String, :length => 2048, :format => :url
  property :race_id, Integer, :required => false
  
  belongs_to :office
  belongs_to :incumbency, "Office", :child_key => [:incumbent_id], :required => false
  has n, :buys

  def name=(str)
    self.slug = Utilities.sluggify(str)
    super
  end
  
  def canonical(options={})
    rep = {
      'id'          => self.id,
      'name'        => self.name,
      'slug'        => self.slug,
      'url'         => self.url,
      'total_spent' => Buy.sum(:total_cost, :candidate_id => self.id) || 0
    }
    rep['buys'] = self.buys.map(&:canonical) if options[:buys]
    rep['office'] = self.office.short_name if self.office
    rep
  end
  
  class Presenter
    attr_reader :model
    
    def initialize(model, &manifest)
      @model = model
      @manifest = manifest
    end
    
    def canonical
      @manifest.call(@model)
    end
    
    def to_json
    end
    
    def to_json_collection
    end
    
    def to_xml
    end
  end
  
  
end
