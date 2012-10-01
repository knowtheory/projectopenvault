$(document).ready () ->
  window.buys              = new POV.models.Buys()
  window.buy_table         = new POV.views.Buy.Table({ collection: buys, el: '#buys' })
  window.ad_count_chart    = new POV.views.Buy.Chart({ collection: buys, el: '#ad_counts.chart' })
  window.ad_spending_chart = new POV.views.Buy.Chart({ collection: buys, el: '#dollar_counts.chart', attribute: 'total_cost', description: 'dollars spent' })
  window.tumblr_links      = new POV.views.TumblrLinks({ tag: tag, el: '#links' })
  buys.fetch({url: url})
