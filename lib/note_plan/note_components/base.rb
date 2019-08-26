=begin

Note components can be told to do things with note file contents

=end
module NotePlan
  module NoteComponents
    class Base
      attr_reader :note_contents

      def initialize(note_contents)
        @note_contents = note_contents
      end
    end
  end
end
