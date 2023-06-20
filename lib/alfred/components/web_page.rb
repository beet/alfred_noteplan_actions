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
        title_string = title_contents || open_graph_title

        return if title_string.nil?

        @title ||= CGI.unescapeHTML(title_string)
      end

      private

      def title_contents
        html.scan(/<title[^>]*>(.*?)<\/title>/).flatten.first
      end

      def open_graph_title
        html.scan(/<meta property="og:title" content="(.*)"( \/)?>/).flatten.first
      end

      def html
        @html ||= open(url).read
      end
    end
  end
end
