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
        date.strftime("%Y-%m-%d")
      end

      def date_human
        date.strftime("%A %B %-d %Y")
      end

      def date
        Date.new(year, month, day)
      end

      def year
        filename.match(/^([\d]{4})/)[0].to_i
      end

      def month
        filename.match(/^[\d]{4}([\d]{2})/)[1].to_i
      end

      def day
        filename.match(/^[\d]{4}[\d]{2}([\d]{2})/)[1].to_i
      end
    end
  end
end
