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

    helpers do
      def protected!
        unless authorized?
          response['WWW-Authenticate'] = %(Basic realm="Restricted Area")
          throw(:halt, [401, "Not authorized\n"])
        end
      end

      def authorized?
        @auth ||=  Rack::Auth::Basic::Request.new(request.env)
        @auth.provided? && @auth.basic? && @auth.credentials && @auth.credentials == ['admin', 'admin']
      end
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
      raise Sinatra::NotFound unless @question = Question.get(params[:id])
      haml :question, :layout => false
    end
    
    get '/questions/:id/followup' do
      headers "X-FRAME-OPTIONS" => "Allow-From http://projectopenvault.com"
      raise Sinatra::NotFound unless @question = Question.get(params[:id])
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
      raise Sinatra::NotFound unless @candidate = Candidate.first(:slug => params[:slug])

      locals = {
        :header           => @candidate.name, 
        :description      => markdown(@candidate.description || ""),
        :slug             => @candidate.slug,
        :url              => "/candidates/#{@candidate.slug}/spending.json",
        :javascript_paths => ["/assets/vault"]
      }
      haml :buy_tables, :layout => :vault, :locals => locals
    end

    get '/candidates/:slug/edit.html' do
      protected!
      raise Sinatra::NotFound unless @candidate = Candidate.first(:slug => params[:slug])      
      haml :edit_candidate, :layout => :vault, :locals => {:credentials => @auth.credentials}
    end

    get '/offices.html' do
      haml "%h1 Office"
    end

    get '/offices/:slug.html' do
      raise Sinatra::NotFound unless @office = Office.first( :slug => params[:slug] )
      locals = {
        :header      => @office.name,
        :description => markdown( @office.description || "" ),
        :slug        => @office.slug,
        :url         => "/offices/#{@office.slug}/spending.json"
      }
      haml :buy_tables, :layout => :vault, :locals => locals
    end

    get '/offices/:slug/edit.html' do
      protected!
      raise Sinatra::NotFound unless @office = Office.first(:slug => params[:slug])      
      haml :edit_office, :layout => :vault, :locals => {:credentials => @auth.credentials}
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
      locals = {
        :header      => @committee.name, 
        :description => markdown( @committee.description || "" ),
        :slug        => @committee.slug,
        :url         => "/committees/#{@committee.slug}/spending.json"
      }
      haml :buy_tables, :layout => :vault, :locals => locals
    end

    get '/committees/:slug/edit.html' do
      protected!
      raise Sinatra::NotFound unless @committee = Committee.first(:slug => params[:slug])      
      haml :edit_committee, :layout => :vault, :locals => {:credentials => @auth.credentials}
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
    helpers do
      def protected!
        unless authorized?
          response['WWW-Authenticate'] = %(Basic realm="Restricted Area")
          throw(:halt, [401, "Not authorized\n"])
        end
      end

      def authorized?
        @auth ||=  Rack::Auth::Basic::Request.new(request.env)
        @auth.provided? && @auth.basic? && @auth.credentials && @auth.credentials == ['admin', 'admin']
      end
    end
    
    get '/' do
      protected!
      @candidates = Candidate.all
      @committees = Committee.all
      @offices = Office.all
      haml :admin, :layout => :vault
    end

    get '/share' do
    end

    get '/shared' do
    end
    
    get '/questions/new' do
    end
    
    get '/questions' do
    end
  end
end
