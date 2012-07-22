module AdVault
  class App < Sinatra::Base
    get '/' do
      haml "%h1 Hello!"
    end
    
    get '/spending' do
    end
    
    get '/spending/candidates' do
    end
    
    get '/spending/office' do
    end
    
    get '/spending/stations' do
    end
    
    get '/spending/advertisers' do
    end
    
    get '/ads' do
    end
    
    get '/ads/candidates' do
    end
    
    get '/ads/office' do
    end
    
    get '/ads/stations' do
    end
    
    get '/ads/advertisers' do
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
