=begin

Alfred action for adding a todo item to today's calendar note:

    print Alfred::Actions::AddTodo.new(ARGV[0]).process

* todo string is an Alfred user setting, like "- [ ] "
* mode is an Alfred user setting, like "append", "prepend"

=end
module Alfred
  module Actions
    class AddTodo < Base
      require "date"

      def process
        callback.url
      end

      private

      def callback
        NotePlan::XCallbackUrl::AddText.new(
          text,
          date: date,
          mode: mode
        )
      end

      def text
        "#{todo_string} #{input}"
      end

      def date
        Date.today
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
