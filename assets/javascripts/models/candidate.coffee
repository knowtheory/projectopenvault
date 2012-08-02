POV.models.Candidate = Backbone.Model.extend
  initalize: (attributes, options) ->
    if option.buys
      this.buys = new POV.models.Buys options.buys.where
        candidate_id: this.id
        
  totalSpent: ->
    this.buys.reduce ((total, buy) -> total + buy.get 'total_spent'), 0

POV.models.Candidates = Backbone.Collection.extend
  url: "/candidates",
  model: POV.models.Candidate