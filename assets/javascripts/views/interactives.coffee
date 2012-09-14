POV.views.Interactives = Backbone.View.extend
  selector: "#interactives"
  id: "interactives"
  initialize: (options) ->
    @collections = []
    window.candidates = new POV.models.Candidates
    window.committees = new POV.models.Committees
    window.offices    = new POV.models.Offices
    
    me = this
    @collections.push candidates, committees, offices
    _.each @collections, (collection) ->
      collection.on 'reset', me.loaded, me
      collection.fetch()

    @loaded = 
      candidates: false
      committees: false
      offices:    false
    @views = 
      spending: new POV.views.Spending
        candidates: candidates
        committees: committees
        offices:    offices
  render:       () -> @renderViews()
  renderViews:  () -> (view.render() for selector, view of @views)
  attach:     (el) -> @setElement(el or @selector) and @attachViews()
  attachViews:  () -> view.attach(this.$el) for selector, view of @views
    
  loaded: (collection, response) ->
    @loaded[collection.name] = true
    statuses = (status for name, status of @loaded)
    if _.all(statuses, (status) -> status)
      @attach() and @render()
