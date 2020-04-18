require "spec_helper"

RSpec.shared_examples NotePlan::NoteFiles::Base do
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
