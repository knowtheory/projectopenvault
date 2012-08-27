POV.Utilities = 
  formatDollars: (value) ->
    characters = '' + value
    groups = []
    group_count = Math.ceil characters.length / 3
    end = characters.length
    while (end > 0)
      start = end - 3
      start = 0 if start < 0
      groups.push(characters.slice(start, end))
      end -= 3
    groups.reverse().join(',')

  superFormatTime: (value) ->
    minute_unit = 60
    hour_unit   = minute_unit * 60
    day_unit    = hour_unit * 24
    days = Math.floor(value / day_unit)
    remaining = value % day_unit
    hours = Math.floor(remaining / hour_unit)
    remaining = remaining % hour_unit
    minutes = Math.floor(remaining / minute_unit)
    remaining = remaining % minute_unit
    seconds = remaining
    "#{days}d:#{hours}h:#{minutes}m:#{seconds}s"

  formatTime: (value) -> Math.floor(value / 60)
