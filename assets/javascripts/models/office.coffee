POV.models.Office = Backbone.Model.extend
  initialize: (attributes, options) ->
    if options.buys
      @buys = new POV.models.Buys options.buys.where
        office_id: @id

POV.models.Offices = Backbone.Collection.extend
  name       : "offices"
  url        : "/offices"
  model      : POV.models.Office
  page_size  : 6
  comparator : (office) -> -office.get('total_spent')
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
