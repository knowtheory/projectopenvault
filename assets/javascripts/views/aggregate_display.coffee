POV.views.AggregateDisplay = Backbone.View.extend
  initialize: (options) ->
    data = options.model
    data.on 'sync', @render, this
  render:    () ->
    this.$el.html """
    <div id="aggregate">
      <p id="total_runtime">
        <span class="value">#{POV.Utilities.formatTime @model.get('duration')}</span>
        <span class="description">Minutes of ads run</span>
      </p>
      <p id="total_spent">
        <span class="value">$#{POV.Utilities.formatDollars @model.get('spent')}</span>
        <span class="description">Spent on ads</span>
      </p>
    </div>
    """
