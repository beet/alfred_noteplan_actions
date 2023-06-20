require "spec_helper"

RSpec.describe NotePlan::RevealInFinder do
  subject(:subject) { described_class.new }

  context "#alfred_items" do
    let(:note_file_1) {
      instance_double(
        NotePlan::NoteFiles::Notes,
        heading: heading_1,
        basename: basename_1,
        filename: filename_1,
      )
    }
    let(:heading_1) { "heading_1" }
    let(:basename_1) { "basename_1" }
    let(:filename_1) { "filename_1" }

    let(:note_file_2) {
      instance_double(
        NotePlan::NoteFiles::Calendar,
        heading: heading_2,
        basename: basename_2,
        filename: filename_2,
      )
    }
    let(:heading_2) { "heading_2" }
    let(:basename_2) { "basename_2" }
    let(:filename_2) { "filename_2" }

    let(:alfred_item_1) { instance_double(Alfred::Item, title: title_1) }
    let(:title_1) { "title_B" }

    let(:alfred_item_2) { instance_double(Alfred::Item, title: title_2) }
    let(:title_2) { "title_A" }

    before do
      allow(Alfred::Item).to receive(:new)
        .with(
          heading_1,
          subtitle: basename_1,
          arg: filename_1
        )
        .and_return(alfred_item_1)

      allow(Alfred::Item).to receive(:new)
        .with(
          heading_2,
          subtitle: basename_2,
          arg: filename_2
        )
        .and_return(alfred_item_2)

      allow(subject).to receive(:for_each_note).and_yield(note_file_1).and_yield(note_file_2)
    end

    it "sorts a collection of Alfred::Item objects for each file note" do
      expect(subject.alfred_items).to eq([alfred_item_2, alfred_item_1])
    end
  end
end
