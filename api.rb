module AdVault
  class API < Grape::API
    version 'v1', :using => :header, :vendor => 'advault'
  end
end
