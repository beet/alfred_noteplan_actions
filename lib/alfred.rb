%w(
  alfred/base
  alfred/item
  alfred/script_filter
).each do |filename|
  require File.expand_path("../#{filename}",  __FILE__)
end
