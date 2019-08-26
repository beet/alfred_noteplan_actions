=begin

Produces the x-callback-url to add text to a given calendar note:

    NotePlan::XCallbackUrl::AddText.new(
      text,
      date: date,
      mode: mode
    ).url

* date: a Date/Time object
* mode: a string like "append", "prepend"

=end
module NotePlan
  module XCallbackUrl
    class AddText < Base
      def parameters
        {
          noteDate: date_string,
          text: input,
          mode: mode
        }
      end

      private

      def date_string
        date.strftime(NotePlan::NoteComponents::NoteDate::DATE_FORMAT)
      end
    end
  end
end
