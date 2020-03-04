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
  class NoteFile
    attr_reader :filename

    def initialize(filename)
      @filename = filename
    end

    def contents
      @contents ||= File.read(filename)
    end

    def basename
      File.basename(filename)
    end

    def heading
      NoteComponents::Heading.new(contents).contents
    end

    def hashtags
      NoteComponents::HashTag.new(contents).contents
    end

    def has_note_links?
      note_links.any?
    end

    def note_links
      @note_links ||= NoteComponents::NoteLinks.new(contents).contents
    end

    def has_journal_entry?
      journal_entry != ""
    end

    def journal_entry
      @journal_entry ||= NoteComponents::JournalEntry.new(contents).contents
    end

    def date
      note_date.date
    end

    def year
      note_date.year
    end

    def month
      note_date.month
    end

    def day
      note_date.day
    end

    private

    def note_date
      @note_date ||= NoteComponents::NoteDate.new(basename)
    end
  end
end
