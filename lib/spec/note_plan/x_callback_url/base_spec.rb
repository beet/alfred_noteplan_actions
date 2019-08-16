require "spec_helper"

RSpec.describe NotePlan::XCallbackUrl::Base do
  class ConcreteCallback < NotePlan::XCallbackUrl::Base; end

  let(:input) { "input" }
  let(:action) { "addText" }
  let(:parameters) { { foo: "bar", sna: "fu" } }

  subject(:callback) { NotePlan::XCallbackUrl::Base.new(input) }

  before do
    allow(callback).to receive(:action).and_return(action)

    allow(callback).to receive(:parameters).and_return(parameters)
  end

  context "#url" do
    let(:url) { subject.url }

    it 'has a base URL of noteplan://x-callback-url' do
      expect(url).to match(/^noteplan:\/\/x-callback-url/)
    end

    it 'sets the path to the concrete class action' do
      expect(url).to match(/x-callback-url\/#{action}\?/)
    end

    context "parameters" do
      before do
        allow(CGI).to receive(:escape).with("bar").and_return("escaped+bar")

        allow(CGI).to receive(:escape).with("fu").and_return("escaped+fu")
      end

      it 'CGI escapes the parameter values' do
        expect(url).to match(/foo=escaped bar&sna=escaped fu/)
      end
    end
  end
end
