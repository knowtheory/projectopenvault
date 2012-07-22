class Candidate
  include DataMapper::Resource
  
  property :id,        Serial
  property :name,      String, :required => true
  property :slug,      String, :length => 2048
  property :incumbent, Boolean, :default => false
  property :url,       String, :length => 2048, :format => :url

  has 1, :office
  has n, :buys

  def name=(str)
    self.slug = Utilities.sluggify(str)
    super
  end
  
  def canonical(options={})
    rep = {
      'id'        => self.id,
      'slug'      => self.slug,
      'url'       => self.url
    }
    rep['buys'] = self.buys.map(&:canonical) if options[:buys]
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
