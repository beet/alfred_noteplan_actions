=begin

PORO to encapsulate a note file:

    note_file = NotePlan::NoteFiles::Notes.new(filename)

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
    class Notes < Base
      def heading
        NoteComponents::Heading.new(contents).contents
      end

      # The journal summary feature is implemented in calendar notes
      def has_journal_entry?
        false
      end

      def journal_entry
        ""
      end
    end
  end
end
