module AdVault
  class App < Sinatra::Base
    configure :development do
      LOGGER = Logger.new("log/development.log")
      enable :logging
    end

    configure :production do
      LOGGER = Logger.new("log/production.log")
      enable :logging
    end

    get '/' do
      @buys = Buy.all
      @candidates = Candidate.all
      haml :tumblr_mockup, :layout => :tumblr_mockup_layout
    end
    
    get '/blocks' do
      @buys = Buy.all
      @candidates = Candidate.all
      haml :tumblr_blocks, :layout => :tumblr
    end
    
    get '/backbone' do
      @buys = Buy.all
      @candidates = Candidate.all
      haml :tumblr_mockup, :layout => :tumblr
    end

    get '/spending.html' do
      haml "%h1 Spending"
    end

    get '/ads.html' do
      haml "%h1 ads"
    end

    get '/candidates.html' do
      haml "%h1 Candidates\n<ul>#{Candidate.map{|c|"<li>#{c.name}</li>"}.join}</ul>"
    end

    get '/candidates/:slug.html' do
      haml "%h1 Candidate #{Candidate.first(:slug=>params[:slug]).name}"
    end

    get '/candidates/:slug/spending.html' do
      haml "%h1 Spending for Candidate #{Candidate.first(:slug=>params[:slug]).name}"
    end

    get '/candidates/:slug/ads.html' do
      haml "%h1 Ads for Candidate #{Candidate.first(:slug=>params[:slug]).name}"
    end

    get '/offices.html' do
      haml "%h1 Office"
    end

    get '/offices/:slug.html' do
      haml "%h1 Office"
    end

    get '/offices/:slug/spending.html' do
      haml "%h1 Office"
    end

    get '/offices/:slug/ads.html' do
      haml "%h1 Office"
    end

    get '/stations.html' do
      haml "%h1 Station"
    end

    get '/stations/:slug.html' do
      haml "%h1 Station"
    end

    get '/stations/:slug/spending.html' do
      haml "%h1 Station"
    end

    get '/stations/:slug/ads.html' do
      haml "%h1 Station"
    end

    get '/advertisers.html' do
      haml "%h1 Advertiser"
    end

    get '/advertisers/:slug.html' do
      haml "%h1 Advertiser"
    end

    get '/advertisers/:slug/spending.html' do
      haml "%h1 Advertiser"
    end

    get '/advertisers/:slug/ads.html' do
      haml "%h1 Advertiser"
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
