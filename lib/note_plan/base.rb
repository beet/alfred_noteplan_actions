=begin

Template class for interacting with NotePlan files.

Concrete classes must implement a #alfred_items abstract method that returns
an array of Alfred::Item instances.

Provides the #for_each_note block method that iterates through all NotePlan
note files and yields a NotePlan::NoteFile instance.

=end
module NotePlan
  class Base
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
      Dir.glob("#{notes_directory}/*.txt") do |filename|
        yield NotePlan::NoteFile.for(filename)
      end
    end

    def for_each_calendar_entry(&block)
      Dir.glob("#{calendar_directory}/*.txt") do |filename|
        yield NotePlan::NoteFile.for(filename)
      end
    end

    def notes_directory
      "#{base_directory}/Notes"
    end

    def calendar_directory
      "#{base_directory}/Calendar"
    end

    def base_directory
      "#{ENV["HOME"]}#{Alfred::Settings.base_directory}"
    end
  end
end
