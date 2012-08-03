POV.views.Interactives = Backbone.View.extend
  id: "interactives"
  initialize: (options) ->
    window.candidates = new POV.models.Candidates
    candidates.on 'reset', this.loaded, this
    candidates.fetch()
    window.committees = new POV.models.Committees
    committees.on 'reset', this.loaded, this
    #committees.fetch()

    this.loaded = 
      candidates: false
      #committees: false
    this.views = 
      spending: new POV.views.Spending
        el: this.$el.find('#spending')
        candidates: candidates
        #committees: committees
        #offices: offices
  render: () ->
    this.$el.append(view.attach()) for name, view of this.views
  detach: () ->
    this.$el.empty()
  loaded: (collection, response) ->
    console.log(collection)
    this.loaded[collection.name] = true
    statuses = (status for name, status of this.loaded)
    console.log(this.loaded)
    if _.all(statuses, (status) -> status)
      console.log("Logging Statuses")
      this.render()
    