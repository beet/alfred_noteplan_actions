module NotePlan
  class Base
    NOTES_DIRECTORY = "#{ENV["HOME"]}/Library/Mobile Documents/iCloud~co~noteplan~NotePlan/Documents/Notes/*.txt"

    private

    class NoteFile
      attr_reader :filename

      def initialize(filename)
        @filename = filename
      end

      def contents
        @contents ||= File.read(filename)
      end
    end

    def for_each_note(&block)
      Dir.glob(NOTES_DIRECTORY) do |filename|
        # yield File.read(filename)
        yield NoteFile.new(filename).contents
      end
    end

    def for_each_note(&block)
      Dir.glob(NOTES_DIRECTORY) do |filename|
        yield File.read(filename)
      end
    end
  end
end
