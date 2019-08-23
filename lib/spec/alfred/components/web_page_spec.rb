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
  end
end
