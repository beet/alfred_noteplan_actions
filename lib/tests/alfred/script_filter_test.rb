require 'minitest/autorun'
require_relative "../../alfred.rb"

describe Alfred::ScriptFilter do
  before do
    @script_filter = Alfred::ScriptFilter.new
  end

  describe "#items" do
    it "is an array" do
      assert_equal(@script_filter.items, [])
    end
  end

  describe "json" do
    before do
      attributes = { foo: "bar" }

      @script_filter.items << attributes
    end

    it "produces a JSON structure as expected by the Alfred script filter workflow input" do
      assert_equal(@script_filter.json, %({"items":[{"foo":"bar"}]}))
    end
  end
end
