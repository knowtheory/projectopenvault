module AdVault
  class Api < Grape::API
    version 'v1', :using => :header, :vendor => 'advault'

    helpers do
      def logger
        Api.logger
      end
    end
    
    get :spending do
      "Spending Data\n"
    end

    get :ads do
    end
        
    resource :candidates do
      segment "/:slug" do
        get do
          Candidate.first(:slug=>params[:slug]).canonical(:buys=>true).to_json
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
      
        resource :spending do
          get do
            "Hallo!"
          end
        end
        
        resource :ads do
          get do
            "Ads!"
          end
        end
      end
    end
    
    resource :offices do
      get ":slug" do
        Office.first(:slug=>params[:slug]).canonical.to_json
      end
    end
    
    resource :stations do
      get ":call_sign" do
        Station.first(:call_sign=>params[:call_sign]).canonical.to_json
      end
    end
  end
end
