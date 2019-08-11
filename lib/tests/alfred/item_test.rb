require 'minitest/autorun'
require_relative "../../alfred.rb"

describe Alfred::Item do
  describe "constructor" do
    before do
      @title = MiniTest::Mock.new("title")
    end

    describe "main argument" do
      it "assigns the title" do
        title = MiniTest::Mock.new("title")

        item = Alfred::Item.new(title)

        assert_equal(item.title, title)
      end
    end

    describe ":subtitle" do
      it "defaults to the title" do
        item = Alfred::Item.new(@title)

        assert_equal(item.subtitle, @title)
      end

      it "assigns the subtitle" do
        subtitle = MiniTest::Mock.new("subtitle")

        item = Alfred::Item.new(@title, subtitle: subtitle)

        assert_equal(item.subtitle, subtitle)
      end
    end

    describe ":arg" do
      it "defaults to the title" do
        item = Alfred::Item.new(@title)

        assert_equal(item.arg, @title)
      end

      it "assigns the arg" do
        arg = MiniTest::Mock.new("arg")

        item = Alfred::Item.new(@title, arg: arg)

        assert_equal(item.arg, arg)
      end
    end

    describe ":autocomplete" do
      it "defaults to the title" do
        item = Alfred::Item.new(@title)

        assert_equal(item.autocomplete, @title)
      end

      it "assigns the autocomplete" do
        autocomplete = MiniTest::Mock.new("autocomplete")

        item = Alfred::Item.new(@title, autocomplete: autocomplete)

        assert_equal(item.autocomplete, autocomplete)
      end
    end
  end

  describe "#attributes" do
    before do
      @title = " test,title! "

      @arg = MiniTest::Mock.new("arg")

      @autocomplete = MiniTest::Mock.new("autocomplete")

      @item = Alfred::Item.new(@title)
    end

    describe ":title" do
      it "is the title" do
        assert_equal(@item.attributes[:title], @title)
      end
    end

    describe ":subtitle" do
      it "is the subtitle" do
        subtitle = MiniTest::Mock.new("subtitle")

        @item.stub(:subtitle, subtitle) do
          assert_equal(@item.attributes[:subtitle], subtitle)
        end
      end
    end

    describe ":arg" do
      it "is the arg" do
        arg = MiniTest::Mock.new("arg")

        @item.stub(:arg, arg) do
          assert_equal(@item.attributes[:arg], arg)
        end
      end
    end

    describe ":autocomplete" do
      it "is the autocomplete" do
        autocomplete = MiniTest::Mock.new("autocomplete")

        @item.stub(:autocomplete, autocomplete) do
          assert_equal(@item.attributes[:autocomplete], autocomplete)
        end
      end
    end

    describe ":match" do
      it "strips whitespace out of the title" do
        assert_equal(@item.attributes[:match], "test title")
      end
    end
  end
end
