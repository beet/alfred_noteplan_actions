require 'minitest/autorun'
require_relative "../../note_plan.rb"
require_relative "../lib/mock_note_file_iterator"

describe NotePlan::HashTags do
  include MockNoteFileIterator

  before do
    @subject = NotePlan::HashTags.new
  end

  describe "#alfred_items" do
    before do
      @foo_alfred_item = MiniTest::Mock.new("Alfred::Item - foo")

      @bar_alfred_item = MiniTest::Mock.new("Alfred::Item - bar")
    end

    it "does something" do
      with_mock_note_file_iteration do |mock_file_note|
        mock_file_note.expect(:hashtags, %w(#foo #bar))

        # WTF?!?! Stubbing Alfred::Item.new here seems to bleed out into all
        # the other tests?
        # 
        # Alfred::Item.stub(:new, @foo_alfred_item, "#foo") do
        #   Alfred::Item.stub(:new, @bar_alfred_item, "#bar") do
        #     puts @subject.alfred_items
        #   end
        # end
      end
    end
  end
end
