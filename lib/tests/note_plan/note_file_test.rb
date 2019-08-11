require 'minitest/autorun'
require_relative "../../note_plan.rb"

describe NotePlan::NoteFile do
  before do
    @basename = "20190718.txt"

    @filename = "somme/nested/directory/#{@basename}"

    @note_file = NotePlan::NoteFile.new(@filename)

    @file_contents = MiniTest::Mock.new("file_contents")
  end

  describe "#contents" do
    before do
      @mock_file = MiniTest::Mock.new

      # Nasty DSL for stubbing methods with an argument, seems to be
      # expect(:method, response, [arguments])
      @mock_file.expect :call, @file_contents, [@filename]
    end

    it "reads the note file contents" do
      File.stub(:read, @mock_file) do
        assert_equal(@note_file.contents, @file_contents)
      end
    end
  end

  describe "#basename" do
    it "is the last component of the filename" do
      assert_equal(@note_file.basename, @basename)
    end
  end

  def with_stubbed_file_contents(&block)
    @note_file.stub(:contents, @file_contents) do
      yield
    end
  end

  describe "#heading" do
    before do
      @heading_component = MiniTest::Mock.new("NotePlan::NoteComponents::Heading")

      @heading_contents = MiniTest::Mock.new("heading_contents")

      @heading_component.expect(:contents, @heading_contents)
    end

    it "is the heading contents" do
      with_stubbed_file_contents do
        NotePlan::NoteComponents::Heading.stub(:new, @heading_component) do
          assert_equal(@note_file.heading, @heading_contents)
        end
      end
    end
  end

  describe "#hashtags" do
    before do
      @hashtag_component = MiniTest::Mock.new("NotePlan::NoteComponents::HashTag")

      @hashtag_contents = MiniTest::Mock.new("hashtag_contents")

      @hashtag_component.expect(:contents, @hashtag_contents)
    end

    it "is the hashtags contents" do
      with_stubbed_file_contents do
        NotePlan::NoteComponents::HashTag.stub(:new, @hashtag_component) do
          assert_equal(@note_file.hashtags, @hashtag_contents)
        end
      end
    end
  end
end
