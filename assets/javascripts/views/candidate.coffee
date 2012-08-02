POV.views.CandidateBadge = Backbone.View.extend
  model: POV.models.Candidate
  render: ->
    """
    <div class="badge">
      <img></img>
      <div class="info">
        <p class="name">#{this.model.get('name')}</p>
        <p class="office">#{this.model.get('office')}</p>
        <p class="dollars-spent">#{this.model.buys.total_spent}</p>
      </div>
    </div>
    """