require "spec_helper"

describe Tag do

  subject { Fabricate :tag }

  it { is_expected.to have_and_belong_to_many(:articles) }
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_uniqueness_of(:name) }

  describe "#frequency" do

    let(:tag) { Fabricate :tag }

    before do
      Fabricate :article, tags: [ tag ]
      Fabricate :article, tags: [ tag ]
    end

    it "knows how often it's used" do
      expect(tag.frequency).to eq 2
    end

  end

end
