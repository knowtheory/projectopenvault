module Utilities
  def self.pick(hash, *keys)
    filtered = {}
    hash.each {|key, value| filtered[key] = value if keys.include?(key) }
    filtered
  end
  
  def self.sluggify(str)
    slugged = str.gsub(/[^\x00-\x7F]/n, '').to_s # As ASCII
    slugged = slugged.gsub(/[']+/, '') # Remove all apostrophes.
    slugged = slugged.gsub(/\W+/, ' ') # All non-word characters become spaces.
    slugged = slugged.squeeze(' ')     # Squeeze out runs of spaces.
    slugged = slugged.strip            # Strip surrounding whitespace
    slugged.downcase!         # Ensure lowercase.
    # Truncate to the nearest space.
    if slugged.length > 100
      words = slugged[0...50].split(' ')
      slugged = words[0, words.length - 1].join(' ')
    end
    slugged.gsub(' ', '-')   # Dasherize spaces.
  end
  
  def self.format_seconds(time)
    day_in_seconds = 60*60*24
    hour_in_seconds = 60*60
    minute_in_seconds = 60
    days = time / day_in_seconds
    remaining = time % day_in_seconds
    hours = remaining / hour_in_seconds
    remaining = remaining % hour_in_seconds
    minutes = remaining / 60
    seconds = remaining % 60
    "#{days}d, #{hours}h, #{minutes}m, #{seconds}s"
  end
end