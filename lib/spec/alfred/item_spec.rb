require "spec_helper"

RSpec.describe Alfred::Item do
  subject(:alfred_item) { Alfred::Item.new(title, params) }
  let(:title) { "title" }
  let(:params) { {} }

  context "#attributes" do
    let(:attributes) { alfred_item.attributes }

    context ":title" do
      it 'is the given title' do
        expect(attributes[:title]).to eq(title)
      end
    end

    context ":subtitle" do
      it 'defaults to the title' do
        expect(attributes[:subtitle]).to eq(title)
      end

      context "when provided in the options hash" do
        let(:params) { { subtitle: subtitle } }
        let(:subtitle) { "subtitle" }

        it 'is the given subtitle' do
          expect(attributes[:subtitle]).to eq(subtitle)
        end
      end
    end

    context ":arg" do
      it 'defaults to the title' do
        expect(attributes[:arg]).to eq(title)
      end

      context "when provided in the options hash" do
        let(:params) { { arg: arg } }
        let(:arg) { "arg" }

        it 'is the given arg' do
          expect(attributes[:arg]).to eq(arg)
        end
      end
    end

    context ":autocomplete" do
      it 'defaults to the title' do
        expect(attributes[:autocomplete]).to eq(title)
      end

      context "when provided in the options hash" do
        let(:params) { { autocomplete: autocomplete } }
        let(:autocomplete) { "autocomplete" }

        it 'is the given autocomplete' do
          expect(attributes[:autocomplete]).to eq(autocomplete)
        end
      end
    end

    context ":match" do
      let(:title) { "foo-bar" }

      it 'is the title with non-word characters removed' do
        expect(attributes[:match]).to eq("foo bar")
      end
    end
  end
end
