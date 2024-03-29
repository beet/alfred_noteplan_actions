require "spec_helper"

RSpec.describe NotePlan::Base do
  class NotePlan::ConcreteClass < NotePlan::Base
    # Abstract method that should return a collection of Alfred::Item objects
    def alfred_items; end

    def note_files
      [].tap do |array|
        for_each_note do |note_file|
          array << note_file
        end
      end
    end

    def calendar_notes
      [].tap do |array|
        for_each_calendar_entry do |note_file|
          array << note_file
        end
      end
    end
  end

  module Settings
    def base_directory
      method_missing(:base_directory)
    end

    def file_extension
      method_missing(:file_extension)
    end
  end

  before do
    Alfred::Settings.extend(Settings)

    allow(Alfred::Settings).to receive(:base_directory).and_return(base_directory)
    allow(Alfred::Settings).to receive(:file_extension).and_return(file_extension)
  end

  let(:alfred_item) { double(Alfred::Item, attributes: attributes) }
  let(:attributes) { { foo: "bar" } }
  let(:base_directory) { "/Library/Mobile Documents/iCloud~co~noteplan~NotePlan/Documents" }
  let(:file_extension) { "md" }

  subject(:concrete_class) { NotePlan::ConcreteClass.new }

  context "#json" do
    let(:alfred_script_filter) {
      double(
        Alfred::ScriptFilter,
        items: alfred_script_filter_items,
        json: alfred_script_filter_json
      )
    }
    let(:alfred_script_filter_items) { double(Array) }
    let(:alfred_script_filter_json) { double("alfred_script_filter_json") }

    before do
      allow(Alfred::ScriptFilter).to receive(:new).and_return(alfred_script_filter)

      allow(concrete_class).to receive(:alfred_items).and_return([alfred_item])
    end

    it 'adds the concrete class alfred items to the Alfred script filter' do
      allow(alfred_script_filter).to receive(:json)

      expect(alfred_script_filter_items).to receive(:concat).with([alfred_item.attributes])

      concrete_class.json
    end

    it 'returns the Alfred script filter json' do
      allow(alfred_script_filter_items).to receive(:concat)
      
      expect(concrete_class.json).to eq(alfred_script_filter_json)
    end
  end

  context "text note iteration" do
    let(:notes_directory) { "#{ENV["HOME"]}#{base_directory}/Notes/**/*.#{file_extension}" }
    let(:notes_base_directory) { "#{ENV["HOME"]}#{base_directory}/Notes" }
    let(:note_file) {
      instance_double(
        NotePlan::NoteFiles::Notes,
        filename: filename,
        base_directory: notes_base_directory,
      )
    }
    let(:filename) { "filename" }

    before do
      allow(Dir).to receive(:glob).with(notes_directory).and_yield(filename)

      allow(NotePlan::NoteFile).to receive(:for).with(filename, base_directory: notes_base_directory).and_return(note_file)
    end

    it 'yields a NotePlan::NoteFile object instantiated with each filename in the text notes directory' do
      expect(concrete_class.note_files).to eq([note_file])
    end
  end

  context "calendar note iteration" do
    let(:notes_directory) { "#{ENV["HOME"]}#{base_directory}/Calendar/*.#{file_extension}" }
    let(:calendar_base_directory) { "#{ENV["HOME"]}#{base_directory}/Calendar" }
    let(:note_file) {
      instance_double(
        NotePlan::NoteFiles::Calendar,
        filename: filename,
        base_directory: calendar_base_directory,
      )
    }
    let(:filename) { "filename" }

    before do
      allow(Dir).to receive(:glob).with(notes_directory).and_yield(filename)

      allow(NotePlan::NoteFile).to receive(:for).with(filename, base_directory: calendar_base_directory).and_return(note_file)
    end

    it 'yields a NotePlan::NoteFile object instantiated with each filename in the calendar notes directory' do
      expect(concrete_class.calendar_notes).to eq([note_file])
    end
  end
end
