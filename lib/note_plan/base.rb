=begin

Template class for interacting with NotePlan files.

Concrete classes must implement a #alfred_items abstract method that returns
an array of Alfred::Item instances.

Provides the #for_each_note block method that iterates through all NotePlan
note files and yields a NotePlan::NoteFile instance.

=end
module NotePlan
  class Base
    NOTES_DIRECTORY = "#{ENV["HOME"]}/Library/Mobile Documents/iCloud~co~noteplan~NotePlan/Documents/Notes/*.txt"

    attr_reader :alfred_script_filter

    def initialize
      @alfred_script_filter = Alfred::ScriptFilter.new
    end

    def json
      alfred_script_filter.items.concat(alfred_items.map(&:attributes))

      alfred_script_filter.json
    end

    private

    def for_each_note(&block)
      Dir.glob(NOTES_DIRECTORY) do |filename|
        yield NotePlan::NoteFile.new(filename).contents
      end
    end
  end
end
