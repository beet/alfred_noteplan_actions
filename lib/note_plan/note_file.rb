=begin

PORO to encapsulate a note file:

    note_file = NotePlan::NoteFile.for(filename)

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
  class NoteFile
    class << self
      # See NotePlan::Base#notes_directory and
      # NotePlan::Base#calendar_directory. A filename like
      # "/Users/foo/Library/Mobile
      # Documents/iCloud~co~noteplan~NotePlan/Documents/Calendar/20200303.txt"
      # will evaluate to NotePlan::NoteFiles::Calendar, and for text notes to
      # NotePlan::NoteFiles::Notes
      def for(filename)
        module_eval("NotePlan::NoteFiles::#{File.basename(File.dirname(filename))}").new(filename)
      end
    end
  end
end
