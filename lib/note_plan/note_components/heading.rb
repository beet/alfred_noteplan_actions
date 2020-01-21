=begin

Instantiate with a note's contents, and it will return the first instance of a
level 1 heading:

    > NotePlan::NoteComponents::Heading.new(note_contents).contents
    => "# Foo"

=end
module NotePlan
  module NoteComponents
    class Heading < Base
      def contents
        note_contents.scan(/^#[\s]+.*$/).first.gsub(/^# /, "")
      end
    end
  end
end
