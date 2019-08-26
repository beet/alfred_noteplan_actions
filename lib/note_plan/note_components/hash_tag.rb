=begin

This component extracts hashtags from a note file's contents:

    NotePlan::NoteComponents::HashTag.new(contents).contents
    => ["#foo", "#bar"]

=end
module NotePlan
  module NoteComponents
    class HashTag < Base
      def contents
        note_contents.scan(/#[\w-]+\b/)
      end
    end
  end
end
