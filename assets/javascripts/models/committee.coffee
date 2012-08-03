POV.models.Committee = Backbone.Model.extend
  initialize: (attributes, options) ->
    if options.buys
      this.buys = new POV.models.Buys options.buys.where
        candidate_id: this.id
        
  #totalSpent: ->
    #this.buys.reduce ((total, buy) -> total + buy.get 'total_cost'), 0
    
  headshot_url: ->
    "#{POV.host}/assets/#{this.get('slug')}_headshot.jpg"

POV.models.Committees = Backbone.Collection.extend
  name       : "committee"
  url        : "/committees"
  model      : POV.models.Committee
  comparator : (committee) -> -committee.get('total_spent')
  page_size  : 6
  pages      : (page_size=6) ->
    this.pages ||= []
    model_count = this.length
    page_index = 0
    index = 0
    while index < model_count - 1
      page_index = Math.floor(index / page_size)
      (this.pages[page_index] ||= []).push(this.models[index])
      index += 1
    this.pages
  page: (num, page_size) ->
    this.pages(page_size)[num-1]
