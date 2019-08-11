require 'minitest/autorun'
require_relative "../../../note_plan.rb"

describe NotePlan::NoteComponents::HashTag do
  before do
    @note_contents = "# Heading\n\nBody\n\n#hastag1 #hastag2 #hashtag3\n"

    @component = NotePlan::NoteComponents::HashTag.new(@note_contents)
  end

  describe "#contents" do
    it "scans the note contents for hashtags" do
      assert_equal(@component.contents, ["#hastag1", "#hastag2", "#hashtag3"])
    end
  end
end
