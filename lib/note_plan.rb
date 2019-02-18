# require "./note_plan/base.rb"
# require "./note_plan/hash_tags.rb"

%w(
  note_plan/base
  note_plan/hash_tags
  note_plan/wiki_links
  note_plan/note_file
).each do |filename|
  require File.expand_path("../#{filename}",  __FILE__)
end
