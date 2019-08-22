=begin

Produces the x-callback-url to open a text note by the given title:

    NotePlan::XCallbackUrl::OpenNote.new(ARGV[0]).url

=end
module NotePlan
  module XCallbackUrl
    class OpenNote < Base
      def action
        "openNote"
      end

      def parameters
        {
          noteTitle: input
        }
      end
    end
  end
end
