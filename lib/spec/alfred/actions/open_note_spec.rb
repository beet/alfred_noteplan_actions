require "spec_helper"

RSpec.describe Alfred::Actions::OpenNote do
  let(:input) { "some page heading" }
  let(:callback) { double(NotePlan::XCallbackUrl::OpenNote, url: callback_url) }
  let(:callback_url) { double("callback_url") }

  subject(:action) { Alfred::Actions::OpenNote.new(input) }

  before do
    allow(NotePlan::XCallbackUrl::OpenNote).to receive(:new).with(input).and_return(callback)
  end

  context "#process" do
    it 'construct an x-callback-url from the given input with NotePlan::XCallbackUrl::OpenNote' do
      expect(action.process).to eq(callback_url)
    end
  end
end
