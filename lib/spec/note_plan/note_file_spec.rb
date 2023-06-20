require "spec_helper"

RSpec.describe NotePlan::NoteFile do
  context "for" do
    subject(:note_file) { described_class.for(filename, base_directory: base_directory) }

    context "with the path to a calendar note" do
      let(:filename) { "/Users/foo/Library/Mobile Documents/iCloud~co~noteplan~NotePlan/Documents/Calendar/20200303.txt" }
      let(:base_directory) { "/Users/foo/Library/Mobile Documents/iCloud~co~noteplan~NotePlan/Documents/Calendar" }

      it 'is a NotePlan::NoteFiles::Calendar instance' do
        expect(note_file).to be_a(NotePlan::NoteFiles::Calendar)
      end
    end

    context "with the path to a text note" do
      let(:filename) { "/Users/foo/Library/Mobile Documents/iCloud~co~noteplan~NotePlan/Documents/Notes/Title.txt" }
      let(:base_directory) { "/Users/foo/Library/Mobile Documents/iCloud~co~noteplan~NotePlan/Documents/Notes" }

      it 'is a NotePlan::NoteFiles::Notes instance' do
        expect(note_file).to be_a(NotePlan::NoteFiles::Notes)
      end

      context "that is in a sub-folder" do
        let(:filename) { "/Users/foo/Library/Containers/co.noteplan.NotePlan3/Data/Library/Application Support/co.noteplan.NotePlan3/Notes/@Trash/Title.md" }

        it 'is a NotePlan::NoteFiles::Notes instance' do
          expect(note_file).to be_a(NotePlan::NoteFiles::Notes)
        end
      end
    end
  end
end
