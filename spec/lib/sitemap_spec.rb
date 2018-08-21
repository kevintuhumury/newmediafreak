require 'spec_helper'

RSpec.describe Sitemap do

  let(:sitemap)  { Rails.root.join('public/sitemap.xml') }

  let!(:article) { Fabricate :article }
  let!(:tag)     { Fabricate :tag }

  before do
    allow(Time).to receive(:now) { Time.new(2012, 4, 26, 2, 0, 0) }
    described_class.build!
  end

  after do
    FileUtils.remove sitemap
  end

  it 'builds sitemap.xml' do
    expect(File.read(sitemap)).to eq File.read('spec/support/sitemap.xml')
  end

end
