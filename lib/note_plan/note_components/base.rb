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
