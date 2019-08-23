require "spec_helper"

RSpec.describe NotePlan::XCallbackUrl::OpenNote do
  let(:input) { "input" }

  subject(:callback) { NotePlan::XCallbackUrl::OpenNote.new(input) }

  context "#action" do
    it 'is openNote' do
      expect(callback.url).to include("/openNote?")
    end
  end

  context "#parameters" do
    let(:parameters) { callback.parameters }

    context ":noteTitle" do
      it 'is the given input' do
        expect(parameters[:noteTitle]).to eq(input)
      end
    end
  end
end
