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
    
    resource :spending do
      resource :candidates do
        get ":slug" do
          Candidate.first(:slug=>params[:slug]).canonical(:buys=>true).to_json
        end
      end
    end
    
    get :ads do
    end
    
    resource :ads do
      
    end
    
    resource :candidates do
      get ":slug" do
        Candidate.first(:slug=>params[:slug]).canonical.to_json
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
