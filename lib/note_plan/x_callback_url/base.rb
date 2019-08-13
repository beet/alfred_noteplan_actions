require "cgi"

=begin

Template class for creating NotePlan x-callback-urls. Concrete classes must define:

* #action: string like "addText"
* #parameters: hash like { noteDate: 20180122 }

All parameter values will be CGI escaped.

=end
module NotePlan
  module XCallbackUrl
    class Base
      BASE_URL = "noteplan://x-callback-url"

      attr_reader :input

      def initialize(input)
        @input = input
      end

      def url
        "#{BASE_URL}/#{action}?#{action_parameters}"
      end

      private

      # Template method. Must be a string like "addText"
      def action; end

      # Template method. Must be a hash like { foo: "bar" }
      def parameters; end

      def action_parameters
        parameters.to_a.map do |parameter, value|
          "#{parameter}=#{cgi_escape(value)}"
        end.join("&")
      end

      # Need to CGI escape strings to allow characters like & through the
      # x-callback URL, but for some reason not spaces
      def cgi_escape(string)
        CGI.escape(string).gsub("+", " ")
      end
    end
  end
end
