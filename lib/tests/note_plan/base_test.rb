require 'minitest/autorun'
require_relative "../../note_plan.rb"
require_relative "../lib/mock_note_file_iterator"

# module MockAlfredScriptFilter
#   def with_mock_alfred_script_filter(&block)
#     @mock_alfred_script_filter = MiniTest::Mock.new

#     @mock_alfred_script_filter.expect(:items, [])

#     Alfred::ScriptFilter.stub(:new, @mock_alfred_script_filter) do
#       @subject.stub(:alfred_script_filter, @mock_alfred_script_filter) do
#         yield
#       end
#     end
#   end
# end

describe NotePlan::Base do
  # include MockAlfredScriptFilter
  include MockNoteFileIterator

  class FooClass < NotePlan::Base
    class FooItem < Struct.new(:attributes); end

    # Define the #alfred_items template method to return a mock object with
    # attributes that should be rendered by #json
    def alfred_items
      [FooItem.new(foo: "bar")]
    end

    # Define a public method to test file iteration using for_each_note. The
    # mock file note yielded by with_mock_note_file_iteration will need to
    # have :fubar stubbed.
    def file_notes
      [].tap do |array|
        for_each_note do |note_file|
          array.push(note_file.fubar)
        end
      end
    end
  end

  before do
    @subject = FooClass.new
  end

  describe "#json" do
    it "tells an Alfred::ScriptFilter to convert the alfred_items collection into JSON" do
      assert_equal(@subject.json, %({"items":[{"foo":"bar"}]}))
    end
  end

  # it "does something with a mock Alfred filter" do
  #   with_mock_alfred_script_filter do
  #     puts @subject.alfred_script_filter.inspect
  #   end
  # end

  describe "iterating through note files" do
    it "globs the notes directory and yields a NotePlan::NoteFile instantiated with each filename" do
      with_mock_note_file_iteration do |mock_file_note|
        mock_file_note.expect(:fubar, "fubar")

        assert_equal(@subject.file_notes, ["fubar"])
      end
    end
  end
end
