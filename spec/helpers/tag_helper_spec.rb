require "spec_helper"

describe TagHelper do

  let(:foo) { Fabricate :tag, name: "foo" }
  let(:bar) { Fabricate :tag, name: "bar" }
  let(:baz) { Fabricate :tag, name: "baz" }

  let(:article) { Fabricate :article, tags: [ foo, bar, baz ] }

  before do
    Fabricate :article, tags: [ bar, baz ]
    Fabricate :article, tags: [ bar ]
  end

  context "#tags_for" do

    it "formats the tags sorted by frequency" do
      helper.tags_for(article).should == "bar, baz en foo"
    end

  end

end
