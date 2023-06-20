=begin

Produces JSON for the Alfred script filter input to search notes by their
heading, and pass the full filename into Alfred's browse workflow:

    print NotePlan::RevealInFinder.new.json

=end
module NotePlan
  class RevealInFinder < QuickOpen
    private

    def alfred_item_for(note_file)
      Alfred::Item.new(
        note_file.heading,
        subtitle: note_file.basename,
        arg: note_file.filename
      )
    end
  end
end
