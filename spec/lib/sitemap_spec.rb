require "spec_helper"

describe Sitemap do

  let(:sitemap)  { Rails.root.join("public/sitemap.xml") }

  let!(:article) { Fabricate :article }
  let!(:tag)     { Fabricate :tag }

  before do
    Time.stub(:now).and_return { Time.new(2012, 4, 26, 2, 0, 0) }
    Sitemap.build!
  end

  after do
    FileUtils.remove sitemap
  end

  it "builds sitemap.xml" do
    File.read(sitemap).should == File.read("spec/support/sitemap.xml")
  end

end
