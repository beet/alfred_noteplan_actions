=begin

PORO to encapsulate an Alfred script filter JSON item:

    > Alfred::Item.new("foo").attributes
    => {:title=>"foo", :subtitle=>"foo", :arg=>"foo", :autocomplete=>"foo", :match=>"foo"}

=end
module Alfred
  class Item < Alfred::Base
    attr_reader :value

    def initialize(value)
      @value = value
    end

    def attributes
      {
        # "uid": "desktop", # optional
        # "type": "file", # optional
        title: value,
        subtitle: value, # optional
        arg: value, # the returned value
        autocomplete: value, # the autocomplete value
        match: match_string
        # "icon": {
        #     "type": "fileicon",
        #     "path": "~/Desktop"
        # }
      }
    end

    private

    def match_string
      value.gsub(/[^\w]/, " ").strip
    end
  end
end
