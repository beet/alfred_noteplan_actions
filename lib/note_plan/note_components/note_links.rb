=begin

This component extracts note links from a note file's contents:

    NotePlan::NoteComponents::NoteLink.new(contents).contents
    => ["Foo", "Bar"]

=end
module NotePlan
  module NoteComponents
    class NoteLinks < Base
      def contents
        note_contents.scan(/\[\[[^\]]+\]\]/).map do |link|
          link.gsub(/[\[\]]/, "")
        end
      end
    end
  end
end
