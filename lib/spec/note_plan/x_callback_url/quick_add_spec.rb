require "spec_helper"

RSpec.describe NotePlan::XCallbackUrl::QuickAdd do
  let(:input) { "input" }

  subject(:quick_add) { NotePlan::XCallbackUrl::QuickAdd.new(input) }

  context "#parameters" do
    let(:parameters) { quick_add.parameters }

    context ":noteDate" do
      let(:now) { double(Time) }
      let(:note_date) { double("note_date") }

      before do
        allow(Time).to receive(:now).and_return(now)

        allow(now).to receive(:strftime).with("%Y%m%d").and_return(note_date)
      end

      it 'is the current time in YYYYMMDD format' do
        expect(parameters[:noteDate]).to eq(note_date)
      end
    end

    context ":text" do
      let(:todo_string) { "- [ ]" }

      module Settings
        def todo_string; end
      end

      before do
        Alfred::Settings.extend(Settings)


        allow(Alfred::Settings).to receive(:todo_string).and_return(todo_string)
      end

      it 'prefixes the input with the todo string from the Alfred settings' do
        expect(parameters[:text]).to eq("#{todo_string} #{input}")
      end
    end

    context ":mode" do
      let(:quick_add_mode) { "prepend" }

      module Settings
        def quick_add_mode; end
      end

      before do
        Alfred::Settings.extend(Settings)

        allow(Alfred::Settings).to receive(:quick_add_mode).and_return(quick_add_mode)
      end

      it 'is the quick add mode from the Alfred settings' do
        expect(parameters[:mode]).to eq(quick_add_mode)
      end
    end
  end
end
