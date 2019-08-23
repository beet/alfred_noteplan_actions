require "spec_helper"

RSpec.describe NotePlan::XCallbackUrl::AddText do
  require "date"

  let(:input) { "input" }
  let(:date) { Date.today }
  let(:mode) { double("mode") }

  subject(:callback) {
    NotePlan::XCallbackUrl::AddText.new(
      input,
      date: date,
      mode: mode
    )
  }

  context "#action" do
    it 'is addText' do
      expect(callback.action).to eq("addText")
    end
  end

  context "#parameters" do
    let(:parameters) { callback.parameters }

    context ":noteDate" do
      let(:date_string) { double("date_string") }

      before do
        # TODO: re-factor with NotePlan::NoteComponents::NoteDate::DATE_FORMAT
        allow(date).to receive(:strftime).with("%Y%m%d").and_return(date_string)
      end

      it 'is a formatted string from the :date argument' do
        expect(parameters[:noteDate]).to eq(date_string)
      end
    end

    context ":text" do
      it 'is the input' do
        expect(parameters[:text]).to eq(input)
      end
    end

    context ":mode" do
      it 'is the :mode argument' do
        expect(parameters[:mode]).to eq(mode)
      end
    end
  end
end
