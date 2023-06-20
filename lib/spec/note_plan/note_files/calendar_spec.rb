RSpec.describe NotePlan::NoteFiles::Calendar do
  let(:filename) { "foo/filename.txt" }
  let(:base_directory) { 'foo/Bar' }

  subject(:note_file) { described_class.new(filename, base_directory: base_directory) }

  it_behaves_like NotePlan::NoteFiles::Base

  context "#heading" do
    let(:note_date) {
      double(
        NotePlan::NoteComponents::NoteDate,
        date_formatted: formatted_note_date,
        date_human: date_human
      )
    }
    let(:formatted_note_date) { "formatted_note_date" }
    let(:date_human) { "date_human" }

    before do
      allow(note_file).to receive(:note_date).and_return(note_date)
    end

    it 'is the ISO and formatted note date' do
      expect(note_file.heading).to eq("#{formatted_note_date} - #{date_human}")
    end
  end

  context "#has_journal_entry?" do
    before do
      allow(note_file).to receive(:journal_entry).and_return(journal_entry_contents)
    end

    context "when the journal entry is a blank string" do
      let(:journal_entry_contents) { "" }

      it 'is false' do
        expect(note_file.has_journal_entry?).to be_falsey
      end
    end

    context "when the journal entry is not a blank string" do
      let(:journal_entry_contents) { "feeb" }

      it 'is true' do
        expect(note_file.has_journal_entry?).to be_truthy
      end
    end
  end

  context "#journal_entry" do
    let(:journal_entry_component) { double(NotePlan::NoteComponents::JournalEntry, contents: journal_entry_contents) }
    let(:journal_entry_contents) { double("journal_entry_contents") }
    let(:note_file_contents) { double("note_file_contents") }

    before do
      allow(note_file).to receive(:contents).and_return(note_file_contents)

      allow(NotePlan::NoteComponents::JournalEntry).to receive(:new).with(note_file_contents).and_return(journal_entry_component)
    end

    it 'extracts the journal entry contents with NotePlan::NoteComponents::JournalEntry' do
      expect(note_file.journal_entry).to eq(journal_entry_contents)
    end
  end
end
