require "spec_helper"

describe Tag do

  subject { Fabricate :tag }

  it { should have_and_belong_to_many(:articles) }
  it { should validate_presence_of(:name) }
  it { should validate_uniqueness_of(:name) }

  describe "#frequency" do

    let(:tag) { Fabricate :tag }

    before do
      Fabricate :article, tags: [ tag ]
      Fabricate :article, tags: [ tag ]
    end

    it "knows how often it's used" do
      tag.frequency.should == 2
    end

  end

end
