module AdVault
  class Api < Grape::API
    version 'v1', :using => :header, :vendor => 'advault'

    helpers do
      def logger
        Api.logger
      end
      
      def content_type(type)
        header['Content-Type'] = 'application/json'
      end
    end
    
    resource :spending do
      get do
        content_type :json
        @buys = Buy.all
        @buys.map{ |buy| buy.canonical }.to_json
      end

      segment "/:id" do
        get do
          @buy = Buy.first(:id=>params[:id])
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
        @candidates = Candidate.all
        @candidates.map{ |candidate| candidate.canonical }.to_json
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
    
    resource :offices do
      segment "/:slug" do
        get do
          Office.first(:slug=>params[:slug]).canonical.to_json
        end
        
        post do
        end
        
        put do
        end
        
        delete do
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
