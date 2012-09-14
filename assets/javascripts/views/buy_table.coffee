POV.views.BuyTable = Backbone.View.extend
  tagName: 'table'
  initialize: (options) ->
    options.collection.on('reset', @render, this)
  render: () ->
    @$el.html """
    <tr class="header">
      <th>Station</th>
      <th>Committee</th>
      <th>Run from date</th>
      <th>Run to date</th>
      <th>Run from hour</th>
      <th>Run to hour</th>
      <th>Ads run per week</th>
      <th>Ad length</th>
      <th>Cost per ad</th>
      <th>Total spent</th>
    </tr>
    #{this.table_contents()}
    """

  table_contents: () ->
    render_row = (rows, model) ->
      rows.push("""
      <tr #{ if rows.size % 2 then 'class="odd"' }>
        <td>#{model.get('station')}</td>
        <td>#{model.get('committee')}</td>
        <td>#{model.get('start_date')}</td>
        <td>#{model.get('end_date')}</td>
        <td>#{model.get('start_time')}</td>
        <td>#{model.get('end_time')}</td>
        <td>#{model.get('spots_per_week')}</td>
        <td>#{model.get('length')}</td>
        <td>#{model.get('rate_per_spot')}</td>
        <td>#{model.get('total_cost')}</td>
      </tr>
      """)
      rows
    @collection.reduce(render_row, []).join("\n")
