POV.views.CandidateBadge = Backbone.View.extend
  render: ->
    """
    <div class="badge">
      <img src="#{POV.host}/assets/candidates/#{this.model.get('slug')}_headshot.jpg"}></img>
      <div class="info">
        <p class="name"><a href="#{POV.host}/candidates/#{@model.get('slug')}.html">#{this.model.get('name')}</a></p>
        <p class="office">for #{this.model.get('office') || ''}</p>
        <p class="dollars-spent">$#{POV.Utilities.formatDollars(this.model.get('total_spent') || 0)}</p>
      </div>
    </div>
    """
  attach: -> this.$el.html @render()

POV.views.CommitteeBadge = Backbone.View.extend
  render: ->
    """
    <div class="badge">
      <img src="#{POV.host}/assets/committees/#{this.model.get('slug')}.jpg"}></img>
      <div class="info">
        <p class="name"><a href="#{POV.host}/committees/#{@model.get('slug')}.html">#{this.model.get('name')}</a></p>
        <p class="dollars-spent">$#{POV.Utilities.formatDollars(this.model.get('total_spent') || 0)}</p>
      </div>
    </div>
    """
  attach: -> this.$el.html @render()

POV.views.OfficeBadge = Backbone.View.extend
  render: ->
    """
    <div class="badge">
      <img src="#{POV.host}/assets/offices/#{this.model.get('slug')}.jpg"}></img>
      <div class="info">
        <p class="name"><a href="#{POV.host}/offices/#{@model.get('slug')}.html">#{this.model.get('name')}</a></p>
        <p class="dollars-spent">$#{POV.Utilities.formatDollars(this.model.get('total_spent') || 0)}</p>
      </div>
    </div>
    """
  attach: -> this.$el.html @render()
