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
  day_of_year: (date) -> 
    start_of_year = new Date(date.getFullYear(), 0, 0)
    Math.floor( (date - start_of_year) / (1000 * 60 * 60 * 24) )

  sluggify: (str) ->
    slugged = str.replace(/[^\x00-\x7F]/g, '')
    slugged = slugged.replace(/[']+/g, '')       # Remove all apostrophes.
    slugged = slugged.replace(/\W+/g, ' ')       # All non-word characters become spaces.
    slugged = slugged.replace(/\s+/g, ' ')       # Squeeze out runs of spaces.
    slugged = slugged.replace(/^\s+|\s+$/g, '') # Strip surrounding whitespace
    slugged = slugged.toLowerCase()             # Ensure lowercase.
    ## Truncate to the nearest space.
    if slugged.length > 100
      words = slugged.substring(0,50).split(' ')
      slugged = words.slice(0, words.length - 1).join(' ')
    slugged.replace(/\s/g, '-')   # Dasherize spaces.
    
    