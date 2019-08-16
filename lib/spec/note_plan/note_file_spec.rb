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
end
