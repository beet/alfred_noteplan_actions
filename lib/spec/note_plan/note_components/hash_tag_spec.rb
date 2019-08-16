require "spec_helper"

RSpec.describe NotePlan::NoteComponents::HashTag do
  let(:note_contents) { "# Heading\n\nBody\n\n#foo #bar" }

  subject(:component) { NotePlan::NoteComponents::HashTag.new(note_contents) }

  context "#contents" do
    it 'extracts hashtags from the note contents' do
      expect(component.contents).to eq(%w(#foo #bar))
    end
  end
end
