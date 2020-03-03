=begin

PORO to encapsulate a note file:

    note_file = NotePlan::NoteFile.new(filename)

    note_file.contents
    => <#String>

    note_file.basename
    => "foo.txt"

    note_file.heading
    => "# Foo"

    note_file.hashtags
    => ["#bar"]

=end
module NotePlan
  module NoteFiles
    class Calendar < Base
      # Calendar notes don't have a heading, or rather they can, but for
      # presenting in Alfred script filters use the YYYY-MM-DD formatted date
      def heading
        note_date.date_formatted
      end

      def has_journal_entry?
        journal_entry != ""
      end

      def journal_entry
        @journal_entry ||= NoteComponents::JournalEntry.new(contents).contents
      end
    end
  end
end
