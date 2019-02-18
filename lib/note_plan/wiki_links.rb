module NotePlan
  class WikiLinks < Base
    attr_reader :alfred_script_filter

    def initialize
      @alfred_script_filter = Alfred::ScriptFilter.new
    end

    def json
      alfred_script_filter.items.concat(alfred_items)

      alfred_script_filter.json
    end

    private

    def headings
      [].tap do |array|
        for_each_note do |note|
          array << note.scan(/^#[\s]+.*$/).first.gsub(/^# /, "")
        end
      end.uniq.sort
    end

    def alfred_items
      headings.map do |heading|
        Alfred::Item.new(heading).attributes
      end
    end
  end
end
