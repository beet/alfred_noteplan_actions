=begin

PORO to encapsulate an Alfred script filter JSON item:

    > Alfred::Item.new("foo").attributes
    => {:title=>"foo", :subtitle=>"foo", :arg=>"foo", :autocomplete=>"foo", :match=>"foo"}

Can pass in an optional hash to override other item attributes, like subtitle,
arg, and autocomplete:

    > Alfred::Item.new("foo", subtitle: "bar")

The match string argument returned to Alred is taken from the title, and
removes non-word characters which seem to break the script filter input.

So "foo-bar" will produce a match string of "foo bar"

=end
module Alfred
  class Item < Alfred::Base
    attr_reader :title, :subtitle, :arg, :autocomplete, :match

    def initialize(title, subtitle: nil, arg: nil, autocomplete: nil, match: nil)
      @title = title
      @subtitle = subtitle || title
      @arg = arg || title
      @autocomplete = autocomplete || title
      @match = match || title
    end

    def attributes
      {
        # "uid": "desktop", # optional
        # "type": "file", # optional
        title: title,
        subtitle: subtitle, # optional
        arg: arg, # the returned value
        autocomplete: autocomplete, # the autocomplete value
        match: match
        # "icon": {
        #     "type": "fileicon",
        #     "path": "~/Desktop"
        # }
      }
    end
  end
end
