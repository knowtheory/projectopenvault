POV.views.Buy.Chart = Backbone.View.extend
  className: "chart"
  initialize: (options) ->
    this.collection.on('reset', @render, this)
  render: () ->
    $.plot(this.$el, @chart_data(), @chart_attributes())
  chart_data: () ->
    @d1 = [];
    i = 0
    while (i < Math.PI * 2)
      @d1.push([i, Math.sin(i)]);
      i += 0.25
    
    @d2 = [];
    i = 0
    while (i < Math.PI * 2)
      @d2.push([i, Math.cos(i)]);
      i += 0.25

    @d3 = [];
    i = 0
    while (i < Math.PI * 2)
      @d3.push([i, Math.tan(i)]);
      i += 0.1
    
    [{ label: "sin(x)",  data: @d1}, { label: "cos(x)",  data: @d2}, { label: "tan(x)",  data: @d3}]
  chart_attributes: () ->
    {
      series: {
        lines: { show: true },
        points: { show: false }
      },
      xaxis: {
        ticks: [0, [Math.PI/2, "\u03c0/2"], [Math.PI, "\u03c0"], [Math.PI * 3/2, "3\u03c0/2"], [Math.PI * 2, "2\u03c0"]]
      },
      yaxis: {
        ticks: 10,
        min: -2,
        max: 2
      },
      grid: {
        backgroundColor: { colors: ["#fff", "#eee"] }
      }
    }
