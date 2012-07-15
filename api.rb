module AdVault
  class Spending < Grape::API
    version 'v1', :using => :header, :vendor => 'advault'
  end

  class Ads < Grape::API
    version 'v1', :using => :header, :vendor => 'advault'
  end
end
