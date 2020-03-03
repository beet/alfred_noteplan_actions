require "spec_helper"

RSpec.describe NotePlan::NoteFile do
  context "for" do
    subject(:note_file) { NotePlan::NoteFile.for(filename) }

    context "with the path to a calendar note" do
      let(:filename) { "/Users/foo/Library/Mobile Documents/iCloud~co~noteplan~NotePlan/Documents/Calendar/20200303.txt" }

      it 'is a NotePlan::NoteFiles::Calendar instance' do
        expect(note_file).to be_a(NotePlan::NoteFiles::Calendar)
      end
    end

    context "with the path to a text note" do
      let(:filename) { "/Users/foo/Library/Mobile Documents/iCloud~co~noteplan~NotePlan/Documents/Notes/Title.txt" }

      it 'is a NotePlan::NoteFiles::Notes instance' do
        expect(note_file).to be_a(NotePlan::NoteFiles::Notes)
      end
    end
  end
end
