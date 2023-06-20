=begin

PORO to encapsulate a note file's date.

    filename = "20190822.txt"

    note_date = NotePlan::NoteComponents::NoteDate.new(filename)

    note_date.date
    => <Date: 2019-08-22 ((2458718j,0s,0n),+0s,2299161j)>

    note_date.year
    => 2019

    note_date.month
    => 8

    note_date.day
    => 22

=end
module NotePlan
  module NoteComponents
    class NoteDate
      require "date"

      # NotePlan follows the convention of naming calendar notes as
      # YYYYMMDD.txt.
      DATE_FORMAT = "%Y%m%d"

      attr_reader :filename

      def initialize(filename)
        @filename = filename
      end

      def date_formatted
        return date.strftime("%Y-%m-%d") if daily?
        return "Week #{weekly_week}" if weekly?
        return date.strftime('%B') if monthly?
        return yearly_year if yearly?
      end

      def date_human
        return date.strftime("%A %B %-d %Y") if daily?
        return daily_year if weekly?
        return daily_year if monthly?
        return 'yearly' if yearly?
      end

      private

      def daily?
        /^[\d]{8}\./.match?(filename)
      end

      def weekly?
        /^[\d]{4}-W[\d]{2}\./.match?(filename)
      end

      def monthly?
        /^[\d]{4}-[\d]{2}\./.match?(filename)
      end

      def yearly?
        /^[\d]{4}\./.match?(filename)
      end

      def date
        Date.new(daily_year, daily_month, daily_day || 1)
      end

      def daily_year
        filename.match(/^([\d]{4})/)[0]&.to_i
      end

      def daily_month
        filename.match(/^[\d]{4}-([\d]{2})\./)&.[](1)&.to_i ||
          filename.match(/^[\d]{4}([\d]{2})/)[1]&.to_i
      end

      def daily_day
        filename.match(/^[\d]{4}[\d]{2}([\d]{2})/)&.[](1)&.to_i
      end

      def weekly_week
        filename.match(/^[\d]{4}-W([\d]{2})\./)[1]
      end

      def yearly_year
        filename.match(/^([\d]{4})\./)[1]
      end
    end
  end
end
