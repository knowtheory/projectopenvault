module AdVault
  class Api < Grape::API
    version 'v1', :using => :header, :vendor => 'advault'
    helpers Garner::Mixins::Grape::Cache
    
    helpers do
      def logger
        Api.logger
      end
      
      def content_type(type)
        case type
        when :xml
        else
          header['Content-Type'] = 'application/json'
        end
      end
    end
    
    before do
      logger.info "Hello!"
      header['Cache-Control'] = 'public'
      header['Content-Type']  = 'application/json'
    end
    
    resource :spending do
      get do
        @buys = Buy.all
        @buys.map{ |buy| buy.canonical }.to_json
      end
      
      get '/aggregate' do
        cost, duration = Buy.aggregate(:total_cost.sum, :total_runtime.sum)
        {
          "duration" => duration,
          "spent"    => cost
        }.to_json
      end

      segment "/:id" do
        get do
          @buy = Buy.first(:id=>params[:id])
          error! 'Not Found', 404 unless @buy
          @buy.canonical.to_json
        end
        
        post do
          @buy = Buy.first(:id=>params[:id])
        end
        
        put do
          @buy = Buy.first(:id=>params[:id])
        end
        
        delete do
          @buy = Buy.first(:id=>params[:id])
        end
      end
    end

    resource :ads do
      get do
        "Ads!\n"
      end
      
      segment "/:id" do
        get do
        end
        
        post do
        end
        
        put do
        end
        
        delete do
        end
      end
    end
        
    resource :candidates do
      get do
        cache do
          @candidates = Candidate.all
          @candidates.map{ |candidate| candidate.canonical }.to_json
        end
      end
      
      segment "/:slug" do
        get do
          Candidate.first(:slug=>params[:slug]).canonical.to_json
        end
      
        post do
          Candidate.first(:slug=>params[:slug])
        end
      
        put do
          Candidate.first(:slug=>params[:slug])
        end
      
        delete do
          Candidate.first(:slug=>params[:slug])
        end
      
        get "/spending" do
          "Hallo!"
        end
        
        get "/ads" do
          "Ads!"
        end
      end
    end

    resource :committees do
      get do
        @committees = Committee.all
        @committees.map{ |committee| committee.canonical }.to_json
      end
      
      segment "/:slug" do
        get do
          Committee.first(:slug=>params[:slug]).canonical.to_json
        end
      
        post do
          Committee.first(:slug=>params[:slug]).to_json
        end
      
        put do
          Committee.first(:slug=>params[:slug]).to_json
        end
      
        delete do
          Committee.first(:slug=>params[:slug]).to_json
        end
      
        get "/spending" do
          "Hallo!"
        end
        
        get "/ads" do
          "Ads!"
        end
      end
    end
    
    resource :offices do
      get do
        @offices = Office.all
        @offices.map{ |office| office.canonical }.select{ |attr| attr["total_spent"] > 0 }.to_json
      end
      
      segment "/:slug" do
        get do
          Office.first(:slug=>params[:slug]).canonical.to_json
        end
        
        post do
          Office.first(:slug=>params[:slug]).to_json
        end
        
        put do
          Office.first(:slug=>params[:slug]).to_json
        end
        
        delete do
          Office.first(:slug=>params[:slug]).to_json
        end
        
        get "/spending" do
          "Hallo!"
        end
        
        get "/ads" do
          "Ads!"
        end
      end
    end
    
    resource :stations do
      segment "/:call_sign" do
        get do
          Station.first(:call_sign=>params[:call_sign]).canonical.to_json
        end
        
        post do
          Station.first(:call_sign=>params[:call_sign]).canonical
        end
        
        put do
          Station.first(:call_sign=>params[:call_sign]).canonical
        end
        
        delete do
          Station.first(:call_sign=>params[:call_sign]).canonical
        end
        
        get "/spending" do
          "Hallo!"
        end
        
        get "/ads" do
          "Ads!"
        end
        
      end
    end
  end
end
