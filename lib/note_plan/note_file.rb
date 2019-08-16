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
  end
end
