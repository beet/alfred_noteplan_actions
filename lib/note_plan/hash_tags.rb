module NotePlan
  class HashTags < Base
    attr_reader :alfred_script_filter

    def initialize
      @alfred_script_filter = Alfred::ScriptFilter.new
    end

    def json
      alfred_script_filter.items.concat(alfred_items)

      alfred_script_filter.json
    end

    private

    def tags
      [].tap do |array|
        for_each_note do |note|
          array.concat(
            note.scan(/#[\w-]+\b/)
          )
        end
      end.uniq.sort
    end

    def alfred_items
      tags.map do |tag|
        Alfred::Item.new(tag).attributes
      end
    end
  end
end
