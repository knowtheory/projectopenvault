def pick(hash, *keys)
  filtered = {}
  hash.each {|key, value| filtered[key] = value if keys.include?(key) }
  filtered
end
