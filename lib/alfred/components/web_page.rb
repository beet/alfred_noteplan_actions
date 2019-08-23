=begin

Component for doing things with web pages, like downloading them and
extracting their page title.

    webpage = Alfred::Components::WebPage.new("https://google.com")

    webpage.title
    => "Google"

=end
module Alfred
  module Components
    class WebPage
      require "open-uri"

      attr_reader :url

      def initialize(url)
        @url = url
      end

      def title
        @title ||= html.scan(/<title[^>]*>(.*?)<\/title>/).flatten.first
      end

      private

      def html
        @html ||= open(url).read
      end
    end
  end
end
