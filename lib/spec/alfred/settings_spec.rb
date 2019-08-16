require "spec_helper"

RSpec.describe Alfred::Settings do
  let(:quick_add_mode) { "prepend" }

  before do
    ENV["quick_add_mode"] = quick_add_mode
  end

  it 'creates accessors for Alfred environment variables' do
    expect(Alfred::Settings.quick_add_mode).to eq(quick_add_mode)
  end

  it 'returns nil for accessors that are not environment variables' do
    expect(Alfred::Settings.foo).to be_nil
  end
end
