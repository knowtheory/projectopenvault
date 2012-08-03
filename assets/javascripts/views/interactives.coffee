POV.views.Interactives = Backbone.View.extend
  id: "interactives"
  initialize: (options) ->
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
