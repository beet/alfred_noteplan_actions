=begin

Alfred action to create a text note containing a summary of all journal
entries from the calendar notes:

    Alfred::Actions::CreateJournalSummary.process

=end
module Alfred
  module Actions
    class CreateJournalSummary
      include Singleton

      class << self
        def process
          callback.url
        end

        private

        def callback
          NotePlan::XCallbackUrl::AddNote.new(journal_summary, title: note_title)
        end

        def journal_summary
          NotePlan::JournalSummary.new.process
        end

        def note_title
          "# #{Alfred::Settings.journal_heading.gsub(/^[#]+ /, "")} Summary"
        end
      end
    end
  end
end
