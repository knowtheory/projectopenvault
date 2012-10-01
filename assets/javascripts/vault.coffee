$(document).ready () ->
  window.buys       = new POV.models.Buys()
  buy_table         = new POV.views.Buy.Table({el: '#buys', collection: buys})
  #ad_count_chart    = new POV.views.Buy.Chart({el: '#ad_counts.chart', collection: buys})
  #ad_spending_chart = new POV.views.Buy.Chart({el: '#dollar_counts.chart', collection: buys})
  buys.fetch({url: url})
