require 'rails_helper'

RSpec.describe TagHelper do

  let(:foo) { Fabricate :tag, name: 'foo' }
  let(:bar) { Fabricate :tag, name: 'bar' }
  let(:baz) { Fabricate :tag, name: 'baz' }

  let(:article) { Fabricate :article, tags: [ foo, bar, baz ] }

  before do
    Fabricate :article, tags: [ bar, baz ]
    Fabricate :article, tags: [ bar ]
  end

  context '#tags_for' do

    it 'formats the tags sorted by frequency' do
      expect(helper.tags_for(article)).to eq "#{link_to "bar", tag_url(bar)}, #{link_to "baz", tag_url(baz)} en #{link_to "foo", tag_url(foo)}"
    end

  end

end
