=begin

    NotePlan::NoteComponents::JournalEntry.new(note_contents).contents

=end
module NotePlan
  module NoteComponents
    class JournalEntry < Base
      def contents
        return "" unless contains_journal_entry?

        note_contents.split(journal_heading).last
      end

      private

      def contains_journal_entry?
        note_contents.include?(journal_heading)
      end

      def journal_heading
        Alfred::Settings.journal_heading
      end
    end
  end
end
