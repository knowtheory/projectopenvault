POV.models.TumblrLinks = Backbone.Collection.extend
  parse: (response) -> response.posts

POV.views.TumblrLinks = Backbone.View.extend
  tagName: 'ul'
  initialize: (options) ->
    @tag = options.tag
    if @tag
      @collection = new POV.models.TumblrLinks
      @collection.on('reset', @render, this)
      @collection.fetch(url: "http://projectopenvault.com/search/#{@tag}?format=json", type: "json")

  render: () ->
    model_links = (memo, model) ->
      """<li><a href="#{model.get('url-with-slug')}">#{model.get('regular-title')}</a></li>"""
    this.$el.html @collection.reduce model_links, ""