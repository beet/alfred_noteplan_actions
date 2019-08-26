require "spec_helper"

RSpec.describe NotePlan::QuickOpen do
  subject(:note_plan_hash_tags) { NotePlan::HashTags.new }

  context "#alfred_items" do
    let(:note_file_1) { double(NotePlan::NoteFile, hashtags: %w(foo bar)) }
    let(:note_file_2) { double(NotePlan::NoteFile, hashtags: %w(foo bar)) }
    let(:alfred_item_foo) { double(Alfred::Item) }
    let(:alfred_item_bar) { double(Alfred::Item) }

    before do
      allow(Alfred::Item).to receive(:new).with("foo").and_return(alfred_item_foo)

      allow(Alfred::Item).to receive(:new).with("bar").and_return(alfred_item_bar)

      allow(note_plan_hash_tags).to receive(:for_each_note).and_yield(note_file_1).and_yield(note_file_2)
    end

    it 'is a sorted collection of uniq Alfred::Item objects for all hashtags contained within the text notes' do
      expect(note_plan_hash_tags.alfred_items).to eq([alfred_item_bar, alfred_item_foo])
    end
  end
end
