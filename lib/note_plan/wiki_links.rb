=begin

Produces JSON for the Alfred script filter input to search all headings
contained in all NotePlan files:

    print NotePlan::WikiLinks.new.json

Takes the first top-level heading found in each note.

=end
module NotePlan
  class WikiLinks < Base
    def alfred_items
      headings.map do |heading|
        Alfred::Item.new(heading)
      end
    end

    private

    def headings
      [].tap do |array|
        for_each_note do |note|
          array << note.scan(/^#[\s]+.*$/).first.gsub(/^# /, "")
        end
      end.uniq.sort
    end
  end
end
