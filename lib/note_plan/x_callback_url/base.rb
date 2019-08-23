require "cgi"

=begin

Template class for creating NotePlan x-callback-urls. Concrete classes must define:

* #parameters: hash like { noteDate: 20180122 }

All parameter values will be CGI escaped.

The naming convention is to derive the NotePlan x-callback-url action from the
class name. For example, an action of "addNote" would be inferred from a class
of NotePlan::XCallbackUrl::AddNote

Callbacks are generally constructed with a single input string, but can take
an optional hash that will be exposed as accessor methods for constructing
more complex callback URLs:

  callback = FooCallback.new(input, foo: "bar")

  callback.foo
  => "bar"

  callback.bar
  NoMethodError: undefined method `bar'

=end
module NotePlan
  module XCallbackUrl
    class Base
      BASE_URL = "noteplan://x-callback-url"

      attr_reader :input, :options

      def initialize(input, options = {})
        @input = input

        @options = options
      end

      def url
        "#{BASE_URL}/#{action}?#{action_parameters}"
      end

      def method_missing(option, *args)
        super unless options.has_key?(option)

        options[option]
      end

      private

      # Follows the convention of an x-callback-url action of "addText"
      # matching a class name of "AddText"
      def action
        self.class.name.split("::").last.tap do |class_name|
          class_name[0] = class_name[0].downcase
        end
      end

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
