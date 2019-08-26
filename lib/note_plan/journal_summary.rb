=begin

Produces a chronological summary of journal entries from the calendar notes:

    NotePlan::JournalSummary.new.process

Produces semantic Markdown like:

    # Journal Summary

    ## 2019

    ### January

    #### Tuesday 1

    Lorem ipsum dolor sit amet, consectetur adipiscing elit. Primum quid tu
    dicis breve? Quid enim est a Chrysippo praetermissum in Stoicis?

=end
module NotePlan
  class JournalSummary < Base
    require "date"

    def process
      process_calendar_data

      "".tap do |contents|
        contents << "\n"

        years.keys.sort.each do |year|
          contents << "## #{year}\n\n"

          years[year].keys.sort.each do |month|
            contents << "### #{month_name_for(year, month)}\n\n"

            years[year][month].keys.sort.each do |day|
              note_file = years[year][month][day]

              contents << "#### #{note_file.date.strftime("%A %e")}\n\n"

              contents << "#{note_file.journal_entry.strip}\n\n"
            end
          end
        end
      end
    end

    private

    def process_calendar_data
      for_each_calendar_entry do |note_file|
        next unless note_file.has_journal_entry?

        years[note_file.year] ||= {}

        years[note_file.year][note_file.month] ||= {}

        years[note_file.year][note_file.month][note_file.day] = note_file
      end
    end

    def years
      @years ||= {}
    end

    def month_name_for(year, month)
      Date.new(year, month, 1).strftime("%B")
    end
  end
end
