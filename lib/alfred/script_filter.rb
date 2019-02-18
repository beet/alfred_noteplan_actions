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
