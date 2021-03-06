module AdVault
  class Api < Grape::API
    version 'v1', :using => :header, :vendor => 'advault'
    helpers Garner::Mixins::Grape::Cache
    default_format :json

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
      header['Cache-Control'] = 'public'
      header['Content-Type']  = 'application/json'
    end
    
    resource :spending do
      get do
        @buys = Buy.fulfilled
        @buys.map{ |buy| buy.canonical }.to_json
      end
      
      get '/aggregate' do
        end_date = params[:end_date] || Time.now
        cost, duration = Buy.fulfilled("end_date.lte" => end_date).aggregate(:total_cost.sum, :total_runtime.sum)
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
          @candidates.map{ |candidate| candidate.canonical }.select{ |attr| attr["total_spent"] > 0 }.to_json
        end
      end
      
      segment "/:slug" do
        get do
          error!(404) unless @candidate = Candidate.first(:slug=>params[:slug])
          @candidate.canonical.to_json
        end
      
        resource do
          http_basic do
            logger.info("Basic Auth!")
            true
          end

          post do
            error!(404) unless @candidate = Candidate.first(:slug=>params[:slug])
            attrs = Hash[CGI.parse(request.body.read).map{ |k,v| [k, ((v.kind_of? Array and v.size == 1 ) ? v.first : v )]}]
            @candidate.attributes = Utilities.pick(attrs, "name", "party", "url", "description")

            if @candidate.save
              @candidate.canonical.to_json
            else
              error! @candidate.errors.to_json, 401
            end
          end
      
          put do
            Candidate.first(:slug=>params[:slug])
          end
      
          delete do
            Candidate.first(:slug=>params[:slug])
          end
        end
      
        get "/spending" do
          @candidate = Candidate.first(:slug=>params[:slug])
          logger.info(@candidate.inspect)
          error!(404) unless @candidate
          Buy.fulfilled(:candidate_id => @candidate.id).map{ |b| b.canonical }.to_json
        end
        
        get "/ads" do
          "Ads!"
        end
      end
    end

    resource :committees do
      get do
        conditions = Utilities.pick(params, *%w(type))
        conditions.delete "type" if conditions["type"] and conditions["type"] == "all"
        @committees = Committee.all(conditions)
        @committees -= Committee.all(:type => :candidate) unless params['type'] and params['type'] == "all"
        @committees.map{ |committee| committee.canonical }.select{ |attr| attr["total_spent"] > 0 }.to_json
      end
      
      segment "/:slug" do
        get do
          Committee.first(:slug=>params[:slug]).canonical.to_json
        end

        resource do
          http_basic do
            logger.info("Basic Auth!")
            true
          end

          post do
            error!(404) unless @committee = Committee.first(:slug=>params[:slug])
            attrs = Hash[CGI.parse(request.body.read).map{ |k,v| [k, ((v.kind_of? Array and v.size == 1 ) ? v.first : v )]}]
            @committee.attributes = Utilities.pick(attrs, "name", "url", "description")

            if @committee.save
              @committee.canonical.to_json
            else
              error! @committee.errors.to_json, 401
            end
          end
      
          put do
            Committee.first(:slug=>params[:slug]).to_json
          end
      
          delete do
            Committee.first(:slug=>params[:slug]).to_json
          end
        end
      
        get "/spending" do
          @committee = Committee.first(:slug=>params[:slug])
          error!(404) unless @committee
          Buy.fulfilled(:committee_id => @committee.id).map{ |b| b.canonical }.to_json
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
          error!(404) unless @office = Office.first(:slug=>params[:slug])
          @office.canonical.to_json
        end
        
        resource do
          http_basic do
            logger.info("Basic Auth!")
            true
          end

          post do
            error!(404) unless @office = Office.first(:slug=>params[:slug])
            attrs = Hash[CGI.parse(request.body.read).map{ |k,v| [k, ((v.kind_of? Array and v.size == 1 ) ? v.first : v )]}]
            @office.attributes = Utilities.pick(attrs, "name", "url", "description")

            if @office.save
              @office.canonical.to_json
            else
              error! @office.errors.to_json, 401
            end
          end
        
          put do
            Office.first(:slug=>params[:slug]).to_json
          end
        
          delete do
            Office.first(:slug=>params[:slug]).to_json
          end
        end
        
        get "/spending" do
          @office = Office.first(:slug=>params[:slug])
          error!(404) unless @office
          Buy.fulfilled(:office_id => @office.id).map{ |b| b.canonical }.to_json
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
          @station = Station.first(:call_sign=>params[:call_sign])
          error!(404) unless @station
          Buy.fulfilled(:station_id => @station.id).map{ |b| b.canonical }.to_json
        end
        
        get "/ads" do
          "Ads!"
        end
        
      end
    end
  end
end
