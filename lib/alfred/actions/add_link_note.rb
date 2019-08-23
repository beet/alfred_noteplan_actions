=begin

Alfred action for creating a text note containing a link to a website from a
given URL through NotePlan's addNote x-callback-url

    Alfred::Actions::AddLinkNote.new("https://google.com.au").process

=end
module Alfred
  module Actions
    class AddLinkNote < Base
      require "open-uri"

      alias_method :url, :input

      def process
        callback.url
      end

      private

      def callback
        NotePlan::XCallbackUrl::AddNote.new(note_text, title: note_title)
      end

      def web_page
        @web_page ||= Alfred::Components::WebPage.new(url)
      end
   
      def note_text
        %(\n[#{page_title}](#{url})\n\n#links)
      end

      def page_title
        web_page.title || "Untitled"
      end

      def note_title
        "# Link - #{page_title}"
      end
    end
  end
end
