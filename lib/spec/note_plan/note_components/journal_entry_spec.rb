require "spec_helper"

RSpec.describe NotePlan::NoteComponents::JournalEntry do
  subject(:journal_entry) { NotePlan::NoteComponents::JournalEntry.new(note_contents) }

  context "#contents" do
    let(:journal_heading) { "## Journal" }

    module Settings
      def journal_heading; end
    end

    before do
      Alfred::Settings.extend(Settings)


      allow(Alfred::Settings).to receive(:journal_heading).and_return(journal_heading)
    end

    context "when the notes contain a journal entry" do
      let(:note_contents) { "# Heading\n\nBody\n\n#{journal_heading}#{journal_contents}" }
      let(:journal_contents) { "\n\njournal_contents\n" }

      it 'is the journal entry contents' do
        expect(journal_entry.contents).to eq(journal_contents)
      end
    end

    context "when the notes do not contain a journal entry" do
      let(:note_contents) { "# Heading\n\nBody\n\n" }

      it 'is blank' do
        expect(journal_entry.contents).to eq("")
      end
    end
  end
end
