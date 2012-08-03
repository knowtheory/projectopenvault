POV.views.SpendingBadge = Backbone.View.extend
  render: ->
    """
    <div class="badge">
      <img src="#{POV.host}/assets/#{this.model.get('slug')}_headshot.jpg"}></img>
      <div class="info">
        <p class="name">#{this.model.get('name')}</p>
        <p class="office">#{this.model.get('office')}</p>
        <p class="dollars-spent">#{this.model.get('total_spent')}</p>
      </div>
    </div>
    """

POV.views.BadgeList = Backbone.View.extend
  className: "content"
  render: ->
    badges = this.collection.reduce ((html, model) -> html + new POV.views.SpendingBadge(model: model)), ""
    this.$el.html(badges)
  assign: ->
    this.$el.html this.render()