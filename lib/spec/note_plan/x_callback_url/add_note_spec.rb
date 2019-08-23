require "spec_helper"

RSpec.describe NotePlan::XCallbackUrl::AddNote do
  let(:note_body) { double("note_body") }
  let(:title) { double("title") }

  subject(:callback) { NotePlan::XCallbackUrl::AddNote.new(note_body, title: title) }

  context "#parameters" do
    let(:parameters) { callback.parameters }

    context ":noteTitle" do
      it 'is the :title argument' do
        expect(parameters[:noteTitle]).to eq(title)
      end
    end

    context ":text" do
      it 'is the given input' do
        expect(parameters[:text]).to eq(note_body)
      end
    end

    context ":openNote" do
      it 'is "yes"' do
        expect(parameters[:openNote]).to eq("yes")
      end
    end
  end
end
