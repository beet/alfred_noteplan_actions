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
        ENV[setting.to_s] || default_settings[setting.to_sym]
      end

      private

      def default_settings
        {
          base_directory: "/Library/Mobile Documents/iCloud~co~noteplan~NotePlan/Documents",
          journal_heading: "## Journal",
          quick_add_mode: "prepend",
          todo_string: "- [ ]",
        }
      end
    end
  end
end
