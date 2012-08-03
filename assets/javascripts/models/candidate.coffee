POV.models.Candidate = Backbone.Model.extend
  initialize: (attributes, options) ->
    if options.buys
      this.buys = new POV.models.Buys options.buys.where
        candidate_id: this.id
        
  #totalSpent: ->
    #this.buys.reduce ((total, buy) -> total + buy.get 'total_cost'), 0
    
  headshot_url: ->
    "#{POV.host}/assets/#{this.get('slug')}_headshot.jpg"

POV.models.Candidates = Backbone.Collection.extend
  name       : "candidates"
  url        : "/candidates"
  model      : POV.models.Candidate
  comparator : (candidate) -> -candidate.get('total_spent')
  page_size  : 6
  page       : (num) ->
    pages = num
