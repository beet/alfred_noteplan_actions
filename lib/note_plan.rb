Dir["#{__dir__}/note_plan/**/*.rb"].each do |file|
  require_relative file
end
