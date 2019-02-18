=begin

PORO to encapsulate the JSON structure expected by the Alfred script filter
workflow input:

  script_filter = Alfred::ScriptFilter.new
  => #<Alfred::ScriptFilter:0x007f86b987e438 @items=[]>

  script_filter.items << Alfred::Item.new("foo").attributes
  => [{:title=>"foo", :subtitle=>"foo", :arg=>"foo", :autocomplete=>"foo", :match=>"foo"}]

  script_filter.json
  {"items":[{"title":"foo","subtitle":"foo","arg":"foo","autocomplete":"foo","match":"foo"}]}

=end
module Alfred
  class ScriptFilter < Alfred::Base
    require "json"

    attr_reader :items

    def initialize(items = nil)
      @items = items || []
    end

    def json
      response.to_json
    end

    private

    def response
      { items: items }
    end
  end
end
