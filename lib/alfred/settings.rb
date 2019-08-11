require "singleton"

=begin

Interface to the Alfred workflow environment variables that are stored in the
ENV hash:

    quick_add_mode = Alfred::Settings.quick_add_mode
    => "prepend"

    Alfred::Settings.foo
    => nil

=end
module Alfred
  class Settings
    include Singleton

    class << self
      def method_missing(setting, *args)
        ENV[setting.to_s]
      end
    end
  end
end
