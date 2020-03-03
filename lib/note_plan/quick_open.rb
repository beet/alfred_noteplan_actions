=begin

Produces JSON for the Alfred script filter input to search all headings
contained in all NotePlan files:

    print NotePlan::QuickOpen.new.json

Takes the first top-level heading found in each note.

=end
module NotePlan
  class QuickOpen < Base
    def alfred_items
      [].tap do |array|
        for_each_note do |note_file|
          array << alfred_item_for(note_file)
        end

        for_each_calendar_entry do |note_file|
          array << alfred_item_for(note_file)
        end
      end.uniq.sort_by(&:title)
    end

    private

    def alfred_item_for(note_file)
      Alfred::Item.new(
        note_file.heading,
        subtitle: note_file.basename,
        arg: note_file.heading
      )
    end
  end
end
