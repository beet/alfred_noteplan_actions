require "spec_helper"
require "open-uri"

RSpec.describe Alfred::Components::WebPage do
  let(:url) { double("url") }
  let(:tempfile) { double("Tempfile", read: html) }
  let(:html) { nil }

  subject(:web_page) { Alfred::Components::WebPage.new(url) }

  before do
    allow(web_page).to receive(:open).with(url).and_return(tempfile)
  end

  context "#title" do
    let(:html) { "<!DOCTYPE html><html><head><title>#{title}</title></head><body><h1>Heading</h1><p>Contents</p></body></html>" }
    let(:title) { "page title" }

    it 'extracts the page title' do
      expect(web_page.title).to eq(title)
    end

    context "when the <title> tag contains other HTML attributes" do
      let(:html) { %(<!DOCTYPE html><html><head><title lang="en">#{title}</title></head><body><h1>Heading</h1><p>Contents</p></body></html>) }

      it 'ignores them and extracts the page title' do
        expect(web_page.title).to eq(title)
      end
    end

    context "when the title contains HTML encoded characters" do
      let(:title) { "Vegetable Latkes | Mark&#039;s Daily Apple" }

      it 'decodes them' do
        expect(web_page.title).to eq("Vegetable Latkes | Mark's Daily Apple")
      end
    end

    context "when there is no <title> element" do
      let(:html) { "<!DOCTYPE html><html><head></head><body><h1>Heading</h1><p>Contents</p></body></html>" }

      it 'is blank' do
        expect(subject.title).to eq(nil)
      end

      context 'but there is an Open Graph title element' do
        let(:html) {
          <<~HTML
            <!DOCTYPE html>
            <html>
              <head>
                <meta property="og:title" content="#{title}">
              </head>
              <body>
                <h1>Heading</h1>

                <p>Contents</p>
              </body>
            </html>
          HTML
        }

        it 'is the metadata contents' do
          expect(subject.title).to eq(title)
        end
      end
    end
  end
end
