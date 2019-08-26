RSpec.describe Alfred::Actions::CreateJournalSummary do
  context "process" do
    module Settings
      def journal_heading
        method_missing(:journal_heading)
      end
    end

    before do
      Alfred::Settings.extend(Settings)

      allow(Alfred::Settings).to receive(:journal_heading).and_return(journal_heading)

      allow(NotePlan::JournalSummary).to receive(:new).and_return(journal_summary)
    end

    let(:journal_heading) { "## Journal" }
    let(:journal_summary) { double(NotePlan::JournalSummary, process: journal_summary_contents) }
    let(:journal_summary_contents) { double("journal_summary_contents") }
    let(:callback) { double(NotePlan::XCallbackUrl::AddNote, url: callback_url) }
    let(:callback_url) { double("callback_url") }

    subject(:action) { Alfred::Actions::CreateJournalSummary }

    it 'constructs an addNote x-callback-url' do
      allow(NotePlan::XCallbackUrl::AddNote).to receive(:new).and_return(callback)

      expect(action.process).to eq(callback_url)
    end

    context "note contents" do
      it 'is provided by NotePlan::JournalSummary' do
        expect(NotePlan::XCallbackUrl::AddNote).to receive(:new)
          .with(journal_summary_contents, anything)
          .and_return(callback)

        action.process
      end
    end

    context "note title" do
      it 'converts Alfred::Settings.journal_heading into a Markdown H1 and appends "Summary"' do
        expect(NotePlan::XCallbackUrl::AddNote).to receive(:new)
          .with(anything, title: "# Journal Summary")
          .and_return(callback)

        action.process
      end
    end
  end
end
