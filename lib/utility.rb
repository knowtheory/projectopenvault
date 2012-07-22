module Utilities
  def self.pick(hash, *keys)
    filtered = {}
    hash.each {|key, value| filtered[key] = value if keys.include?(key) }
    filtered
  end
  
  def self.sluggify(str)
    slugged = str.gsub(/[^\x00-\x7F]/n, '').to_s # As ASCII
    slugged.gsub!(/[']+/, '') # Remove all apostrophes.
    slugged.gsub!(/\W+/, ' ') # All non-word characters become spaces.
    slugged.squeeze!(' ')     # Squeeze out runs of spaces.
    slugged.strip!            # Strip surrounding whitespace
    slugged.downcase!         # Ensure lowercase.
    # Truncate to the nearest space.
    if slugged.length > 100
      words = slugged[0...50].split(' ')
      slugged = words[0, words.length - 1].join(' ')
    end
    slugged.gsub!(' ', '-')   # Dasherize spaces.
  end
end