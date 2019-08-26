require "spec_helper"

RSpec.describe NotePlan::NoteFile do
  let(:filename) { "foo/filename.txt" }

  subject(:note_file) { NotePlan::NoteFile.new(filename) }

  context "#contents" do
    let(:contents) { double("contents") }

    before do
      allow(File).to receive(:read).with(filename).and_return(contents)
    end

    it 'reads the contents of the file' do
      expect(note_file.contents).to eq(contents)
    end
  end

  context "#basename" do
    let(:basename) { double("basename") }

    before do
      allow(File).to receive(:basename).with(filename).and_return(basename)
    end

    it 'is the base component of the filename' do
      expect(note_file.basename).to eq(basename)
    end
  end

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

  context "#hashtags" do
    let(:file_contents) { double("file_contents") }
    let(:hashtag_component) { double(NotePlan::NoteComponents::HashTag, contents: hashtag_contents) }
    let(:hashtag_contents) { double("hashtag_contents") }

    before do
      allow(note_file).to receive(:contents).and_return(file_contents)

      allow(NotePlan::NoteComponents::HashTag).to receive(:new).with(file_contents).and_return(hashtag_component)
    end

    it 'extracts the hashtags from the file contents with NotePlan::NoteComponents::HashTag' do
      expect(note_file.hashtags).to eq(hashtag_contents)
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

  context "note date" do
    let(:basename) { double("basename") }
    let(:note_date) {
      double(
        NotePlan::NoteComponents::NoteDate,
        date: date,
        year: year,
        month: month,
        day: day
      )
    }
    let(:date) { double("date") }
    let(:year) { double("year") }
    let(:month) { double("month") }
    let(:day) { double("day") }

    before do
      allow(note_file).to receive(:basename).and_return(basename)

      allow(NotePlan::NoteComponents::NoteDate).to receive(:new).with(basename).and_return(note_date)
    end

    context "#date" do
      it 'is delegated to NotePlan::NoteComponents::NoteDate' do
        expect(note_file.date).to eq(note_date.date)
      end
    end

    context "#year" do
      it 'is delegated to NotePlan::NoteComponents::NoteDate' do
        expect(note_file.year).to eq(note_date.year)
      end
    end

    context "#month" do
      it 'is delegated to NotePlan::NoteComponents::NoteDate' do
        expect(note_file.month).to eq(note_date.month)
      end
    end

    context "#day" do
      it 'is delegated to NotePlan::NoteComponents::NoteDate' do
        expect(note_file.day).to eq(note_date.day)
      end
    end
  end
end
