require 'minitest/autorun'
require_relative "../../../note_plan.rb"

describe NotePlan::NoteComponents::Heading do
  before do
    @heading = "Headin 1"

    @note_contents = "# #{@heading}\n\nBody\n\n# Heading 2\n"

    @component = NotePlan::NoteComponents::Heading.new(@note_contents)
  end

  describe "#contents" do
    it "extracts the first level 1 heading from the note contents" do
      assert_equal(@component.contents, @heading)
    end
  end
end
