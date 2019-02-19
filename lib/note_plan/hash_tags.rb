=begin

Produces JSON for the Alfred script filter input to search all hashtags
included in all NotePlan files:

    print NotePlan::HashTags.new.json

=end
module NotePlan
  class HashTags < Base
    def alfred_items
      tags.map do |tag|
        Alfred::Item.new(tag)
      end
    end

    private

    def tags
      [].tap do |array|
        for_each_note do |note_file|
          array.concat(
            note_file.hashtags
          )
        end
      end.uniq.sort
    end
  end
end
