require "spec_helper"

RSpec.describe Alfred::ScriptFilter do
  let(:items) { [{ foo: "bar" }] }

  subject(:script_filter) { Alfred::ScriptFilter.new(items) }

  context "#json" do
    it 'converts the items array into Alfred script filter JSON format' do
      expect(script_filter.json).to eq(%({"items":[{"foo":"bar"}]}))
    end
  end
end
