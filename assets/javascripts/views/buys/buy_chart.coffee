POV.views.Buy.Chart = Backbone.View.extend
  className: "chart"
  initialize: (options) ->
    @collection.on('reset', @render, this)
    @attribute = options.attribute || 'spots_per_week'
    @description = options.description || "ads run"
  render: () ->
    aggregator = (memo, model) -> memo + model.get(@attribute)
    value = @collection.reduce aggregator, 0, this
    this.$el.html """
        <h2>#{ if @attribute == "total_cost" then "$#{POV.Utilities.formatDollars(value)}" else value } total #{@description}</h2>
        <div class="flot" style="width:450px;height:300px"></div>
      """
    $.plot(this.$el.find(".flot"), @chart_data(), @chart_attributes())
  chart_data: () ->
    @buys_by_month = @collection.groupBy (buy) -> POV.Utilities.day_of_year(buy._start_date)
    aggregate_buys = (grouped_buys, group) => 
      sum_spots = (memo, model) => memo += model.get(@attribute)
      [ group, _.reduce( grouped_buys, sum_spots, 0 ) ]

    @spot_count = _.map( @buys_by_month, aggregate_buys )
    [{ label: @description, data: @spot_count }]
  chart_attributes: () ->
    totals = _.map(@buys_by_month, (list, month) -> _.reduce(list, ((memo, num) -> list + num), 0 ) )
    @dates = @collection.map((buy) -> "" + [buy._start_date.getMonth(), buy._start_date.getDate()])
    date_of_year_for_months = (month_number) => 
      month_map = {
        0: "Jan"
        1: "Feb"
        2: "Mar"
        3: "Apr"
        4: "May"
        5: "Jun"
        6: "Jul"
        7: "Aug"
        8: "Sep"
        9: "Oct"
        10: "Nov"
        11: "Dec"
      }
      date = new Date( @collection.first()._start_date.getFullYear(), month_number, 0 )
      [POV.Utilities.day_of_year(date), month_map[month_number]]
    @ticks = _.map([0..12], date_of_year_for_months)
    {
      series: {
        lines: { show: true },
        points: { show: true }
      },
      #xaxis: { ticks: _.map( [_.min(dates).._.max(dates)], @months ) },
      xaxis: { ticks: @ticks },
      yaxis: { min: 0, max: _.max(totals) }
      grid: {
        backgroundColor: { colors: ["#fff", "#eee"] }
      }
    }
