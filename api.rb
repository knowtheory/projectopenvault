module AdVault
  class Api < Grape::API
    version 'v1', :using => :header, :vendor => 'advault'

    helpers do
      def logger
        Api.logger
      end
    end
    
    resource :spending do
      get do
        "Spending Data\n"
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
