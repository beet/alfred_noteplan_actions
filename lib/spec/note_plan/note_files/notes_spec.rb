RSpec.describe NotePlan::NoteFiles::Notes do
  let(:filename) { "foo/filename.txt" }
  let(:base_directory) { 'foo/Bar' }

  subject(:note_file) { described_class.new(filename, base_directory: base_directory) }

  it_behaves_like NotePlan::NoteFiles::Base

  context "#heading" do
    let(:file_contents) { double("file_contents") }
    let(:heading_component) { double(NotePlan::NoteComponents::Heading, contents: heading_contents) }
    let(:heading_contents) { double("heading_contents") }

    before do
      allow(note_file).to receive(:contents).and_return(file_contents)

      allow(NotePlan::NoteComponents::Heading).to receive(:new).with(file_contents).and_return(heading_component)
    end

    it 'extracts the heading from the file contents with NotePlan::NoteComponents::Heading' do
      expect(note_file.heading).to eq(heading_contents)
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

      it 'is false' do
        expect(note_file.has_journal_entry?).to be_falsey
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

    it 'is blank' do
      expect(note_file.journal_entry).to eq("")
    end
  end
end
