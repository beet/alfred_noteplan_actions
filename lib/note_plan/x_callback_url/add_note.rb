=begin

Produces the x-callback-url to create a new text note:

    NotePlan::XCallbackUrl::AddNote.new(note_body, title: title).url

=end
module NotePlan
  module XCallbackUrl
    class AddNote < Base
      def parameters
        {
          noteTitle: title,
          text: input,
          openNote: "yes"
        }
      end
    end
  end
end
