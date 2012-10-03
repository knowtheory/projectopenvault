class Station
  include DataMapper::Resource
  
  property :id,        Serial
  property :name,      String, :required => true
  property :call_sign, String, :required => true
  property :url,       String, :length => 2048, :format => :url
  property :description, Text
  
  has n, :buys

  def canonical(options={})
    rep = {
      'name' => self.name,
      'call_sign' => self.call_sign,
      'url' => self.url,
      'total_spent' => Buy.sum(:total_cost, :station_id => self.id)
    }
    rep['buys'] = self.buys.map(&:canonical) if options[:buys]
    rep
  end
end
