=begin

Include into specs that need to test functionality that uses the
NotePlan::Base#for_each_note block method to iteration through file notes
yielding a NotePlan::NoteFile for each.

It provides a with_mock_note_file_iteration block method that yields a mock
NotePlan::NotePlan which you can set expectations on, before invoking a method
that uses for_each_note to inject values into it.


    include MockNoteFileIterator

    describe "some context" do
      it "does something" do
        with_mock_note_file_iteration do |mock_file_note|
          mock_file_note.expect(:foo, "bar")

          assert_equal(@subject.file_notes, ["fubar"])
        end
      end
    end

=end
module MockNoteFileIterator
  def with_mock_note_file_iteration(&block)
    mock_file_name = MiniTest::Mock.new("filename")

    mock_file_note = MiniTest::Mock.new("NotePlan::NoteFile")

    Dir.stub(:glob, NotePlan::Base::NOTES_DIRECTORY, mock_file_name) do
      NotePlan::NoteFile.stub(:new, mock_file_note, mock_file_name) do
        yield mock_file_note, block
      end
    end
  end
end
