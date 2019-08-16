require "spec_helper"

RSpec.describe NotePlan::NoteComponents::Heading do
  let(:note_contents) { "# Heading 1\n\n# Another Heading 1\n\nBody\n\n## Heading 2\n\n### Heading 3\n" }

  subject(:component) { NotePlan::NoteComponents::Heading.new(note_contents) }

  context "#contents" do
    it 'extracts the first heading 1 from the note contents' do
      expect(component.contents).to eq("Heading 1")
    end
  end
end
