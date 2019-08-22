=begin

    NotePlan::NoteComponents::JournalEntry.new(note_contents).contents

=end
module NotePlan
  module NoteComponents
    class JournalEntry < Base
      def contents
        return "" unless contains_journal_entry?

        note_contents.split(heading_pattern).last
      end

      private

      def contains_journal_entry?
        note_contents.match(heading_pattern) != nil
      end

      def heading_pattern
        @heading_pattern ||= /#{Regexp.escape(journal_heading)}/i
      end

      def journal_heading
        Alfred::Settings.journal_heading
      end
    end
  end
end
