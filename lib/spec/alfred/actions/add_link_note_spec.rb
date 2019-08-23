require "spec_helper"

RSpec.describe Alfred::Actions::AddLinkNote do
  let(:input) { double("url") }
  let(:callback) { double(NotePlan::XCallbackUrl::AddNote, url: callback_url) }
  let(:callback_url) { double("callback_url") }

  subject(:action) { Alfred::Actions::AddLinkNote.new(input) }

  context "#process" do
    before do
      allow(action).to receive(:note_text)
      allow(action).to receive(:note_title)

      allow(NotePlan::XCallbackUrl::AddNote).to receive(:new).and_return(callback)
    end

    it 'constructs an x-callback-url with NotePlan::XCallbackUrl::AddNote' do
      expect(action.process).to eq(callback_url)
    end
  end

  context "callback construction" do
    let(:webpage) { double(Alfred::Components::WebPage, title: page_title) }
    let(:page_title) { "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Primum quid tu dicis breve? Quid enim est a Chrysippo praetermissum in Stoicis?" }
    let(:note_title) { "Link - #{page_title}"[0..(Alfred::Actions::AddLinkNote::NOTE_TITLE_SIZE - 1)] }
    let(:url) { input }
    # let(:note_text) { %([#{page_title}](#{url})\n\n#links) }

    before do
      expect(page_title.size > Alfred::Actions::AddLinkNote::NOTE_TITLE_SIZE).to be_truthy

      allow(Alfred::Components::WebPage).to receive(:new).with(url).and_return(webpage)
    end

    it 'constructs the note text with a link to the webpage and the #links hashtag' do
      expect(NotePlan::XCallbackUrl::AddNote).to receive(:new)
        .with(
          %([#{page_title}](#{url})\n\n#links),
          anything
        )
        .and_return(callback)

      action.process
    end

    it 'constructs the note title ' do
      expect(NotePlan::XCallbackUrl::AddNote).to receive(:new)
        .with(
          anything,
          title: "Link - #{page_title}"[0..(Alfred::Actions::AddLinkNote::NOTE_TITLE_SIZE - 1)]
        )
        .and_return(callback)

      action.process
    end
  end
end
