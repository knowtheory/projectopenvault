module AdVault
 Assets = Sprockets::Environment.new.tap do |env|
    Tilt::CoffeeScriptTemplate.default_bare = true
    %w(stylesheets javascripts images).each do |p|
      env.append_path f = File.expand_path("../assets/#{p}", __FILE__)
    end
  end
end
