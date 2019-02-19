module NotePlan
  module NoteComponents
    class HashTag < Base
      def contents
        note_contents.scan(/#[\w-]+\b/)
      end
    end
  end
end
