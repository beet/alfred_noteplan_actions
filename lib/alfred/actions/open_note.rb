=begin

Alfred action for opening a NotePlan note:

    print Alfred::Actions::OpenNote.new(ARGV[0]).process

=end
module Alfred
  module Actions
    class OpenNote < Base
      def process
        NotePlan::XCallbackUrl::OpenNote.new(input).url
      end
    end
  end
end
