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
      redirect "http://projectopenvault.com", 301
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
    
    get '/questions/:id' do
      headers "X-FRAME-OPTIONS" => "Allow-From http://projectopenvault.com"
      @question = Question.get(params[:id])
      raise Sinatra::NotFound unless @question
      haml :question, :layout => false
    end
    
    get '/questions/:id/followup' do
      headers "X-FRAME-OPTIONS" => "Allow-From http://projectopenvault.com"
      @question = Question.get(params[:id])
      raise Sinatra::NotFound unless @question
      haml :followup, :layout => false
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
      @candidate = Candidate.first(:slug => params[:slug])
      raise Sinatra::NotFound unless @candidate
      haml :candidate, :layout => :vault
    end

    get '/offices.html' do
      haml "%h1 Office"
    end

    get '/offices/:slug.html' do
      raise Sinatra::NotFound unless @office = Office.first( :slug => params[:slug] )
      haml :buy_tables, :layout => :vault, :locals => {:header => @office.name, :url => "/offices/#{@office.slug}/spending.json"}
    end

    get '/offices/:slug/spending.html' do
      haml "%h1 Office"
    end

    get '/offices/:slug/ads.html' do
      haml "%h1 Office"
    end
    
    get '/committees.html' do
      haml "%h1 Committees"
    end

    get '/committees/:slug.html' do
      raise Sinatra::NotFound unless @committee = Committee.first( :slug => params[:slug] )
      haml :buy_tables, :layout => :vault, :locals => {:header => @committee.name, :url => "/committees/#{@committee.slug}/spending.json"}
    end

    get '/stations.html' do
      haml "%h1 Stations"
    end

    get '/stations/:call.html' do
      raise Sinatra::NotFound unless @station = Station.first( :call_sign => params[:call] )
      haml :buy_tables, :layout => :vault, :locals => {:header => @station.name, :url => "/stations/#{@station.call_sign}/spending.json"}
    end

    get '/stations/:call/spending.html' do
      raise Sinatra::NotFound unless @station = Station.first( :call_sign => params[:call] )
      haml :buy_tables, :layout => :vault, :locals => {:header => @station.name, :url => "/stations/#{@station.call_sign}/spending.json"}
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
