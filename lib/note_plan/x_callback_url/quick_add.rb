=begin

Produces the x-callback-url to add a quick todo to today's calendar note:

    NotePlan::XCallbackUrl::QuickAdd.new(ARGV[0]).url

=end
module NotePlan
  module XCallbackUrl
    class QuickAdd < Base
      def action
        "addText"
      end

      def parameters
        {
          noteDate: note_date,
          text: text,
          mode: mode
        }
      end

      private

      def note_date
        Time.now.strftime(NotePlan::NoteComponents::NoteDate::DATE_FORMAT)
      end

      def text
        "#{todo_string} #{input}"
      end

      def todo_string
        Alfred::Settings.todo_string
      end

      def mode
        Alfred::Settings.quick_add_mode
      end
    end
  end
end
