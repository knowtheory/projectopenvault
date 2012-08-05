POV.models.Candidate = Backbone.Model.extend
  initialize: (attributes, options) ->
    if options.buys
      @buys = new POV.models.Buys options.buys.where
        candidate_id: @id
        
  #totalSpent: ->
    #@buys.reduce ((total, buy) -> total + buy.get 'total_cost'), 0
    
  headshot_url: ->
    "#{POV.host}/assets/#{@get('slug')}_headshot.jpg"

POV.models.Candidates = Backbone.Collection.extend
  name       : "candidates"
  url        : "/candidates"
  model      : POV.models.Candidate
  comparator : (candidate) -> -candidate.get('total_spent')
  page_size  : 6
  pages      : (page_size=@page_size) ->
    return @_pages if @_pages?.length == Math.ceil(@length / page_size)
    @_pages = []
    model_count = @length
    page_index = index = 0
    while index < model_count - 1
      page_index = Math.floor(index / page_size)
      (@_pages[page_index] ||= []).push(@models[index])
      index += 1
    @_pages
