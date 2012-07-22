module AdVault
  class App < Sinatra::Base
    get '/' do
      haml "%h1 Hello!"
    end
    
    get '/spending.html' do
      haml "%h1 Spending"
    end
    
    get '/spending/candidates.html' do
      haml "%h1 Spending by Candidate"
    end
    
    get '/spending/office.html' do
      haml "%h1 Spending by Office"
    end
    
    get '/spending/stations.html' do
      haml "%h1 Spending by Station"
    end
    
    get '/spending/advertisers.html' do
      haml "%h1 Spending by Advertiser"
    end
    
    get '/ads.html' do
    end
    
    get '/ads/candidates.html' do
    end
    
    get '/ads/office.html' do
    end
    
    get '/ads/stations.html' do
    end
    
    get '/ads/advertisers.html' do
    end
  end
  
  class Admin < Sinatra::Base
    get '/' do
    end
    
    get '/share' do
    end
    
    get '/shared' do
    end
  end
end
