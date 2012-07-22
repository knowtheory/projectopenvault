module AdVault
  class Api < Grape::API
    version 'v1', :using => :header, :vendor => 'advault'
    
    get :spending do
      "Spending Data\n"
    end
    
    resource :spending do
      get :candidates do
        "Boo!\n"
      end
    end
    
    get :ads do
    end
    
    resource :ads do
      
    end
  end
end
