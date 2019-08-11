Dir["#{__dir__}/alfred/**/*.rb"].each do |file|
  require_relative file
end
