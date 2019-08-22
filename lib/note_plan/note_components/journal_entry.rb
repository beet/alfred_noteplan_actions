=begin

    NotePlan::NoteComponents::JournalEntry.new(note_contents).contents

=end
module NotePlan
  module NoteComponents
    class JournalEntry < Base
      # TODO: Alfred setttings
      IDENTIFIER = "## Journal"

      def contents
        return "" unless contains_journal_entry?

        note_contents.split(IDENTIFIER).last
      end

      private

      def contains_journal_entry?
        note_contents.include?(IDENTIFIER)
      end
    end
  end
end
