require "spec_helper"

describe Article do

  it { should have_and_belong_to_many(:tags) }

  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:content) }
  it { should validate_presence_of(:image) }

  context "when there is only a single article" do

    subject { Fabricate :article, created_at: 1.day.ago }

    let!(:unpublished_before) { Fabricate :article, created_at: 4.days.ago, published: false }
    let!(:unpublished_after)  { Fabricate :article, created_at: Date.today, published: false }

    it "there is no preceding article" do
      expect(subject.preceding).to be_nil
    end

    it "there is no succeeding article" do
      expect(subject.succeeding).to be_nil
    end

  end

  context "when there are two articles" do

    let!(:first_article)  { Fabricate :article, created_at: 2.days.ago }
    let!(:second_article) { Fabricate :article, created_at: Date.today }
    let!(:unpublished)    { Fabricate :article, created_at: 1.day.ago, published: false }

    context "when the first article is selected" do

      subject { first_article }

      it "there is no preceding article" do
        expect(subject.preceding).to be_nil
      end

      it "there is a succeeding article" do
        expect(subject.succeeding).to eq second_article
      end

    end

    context "when the second article is selected" do

      subject { second_article }

      it "there is a preceding article" do
        expect(subject.preceding).to eq first_article
      end

      it "there is no succeeding article" do
        expect(subject.succeeding).to be_nil
      end

    end

  end

  context "when there are three or more articles" do

    let!(:first_article)  { Fabricate :article, created_at: 3.days.ago }
    let!(:second_article) { Fabricate :article, created_at: 2.days.ago }
    let!(:third_article)  { Fabricate :article, created_at: Date.today }
    let!(:unpublished)    { Fabricate :article, created_at: 1.day.ago, published: false }

    context "when the first article is selected" do

      subject { first_article }

      it "there is no preceding article" do
        expect(subject.preceding).to be_nil
      end

      it "there is a succeeding article" do
        expect(subject.succeeding).to eq second_article
      end

    end

    context "when the second article is selected" do

      subject { second_article }

      it "there is a preceding article" do
        expect(subject.preceding).to eq first_article
      end

      it "there is a succeeding article" do
        expect(subject.succeeding).to eq third_article
      end

    end

    context "when the third article is selected" do

      subject { third_article }

      it "there is a preceding article" do
        expect(subject.preceding).to eq second_article
      end

      it "there is no succeeding article" do
        expect(subject.succeeding).to be_nil
      end

    end

  end

  context "preceding articles" do

    let!(:first_article)  { Fabricate :article, created_at: 3.days.ago }
    let!(:second_article) { Fabricate :article, created_at: 2.days.ago }
    let!(:unpublished)    { Fabricate :article, created_at: 4.day.ago, published: false }

    describe "#preceding" do

      it "can find a preceding article" do
        expect(second_article.preceding).to eq first_article
      end

      it "can't find a preceding article" do
        expect(first_article.preceding).to be_nil
      end

    end

    describe "#has_preceding?" do

      it "knows when there is a preceding article" do
        expect(second_article.has_preceding?).to be_true
      end

      it "knows when there isn't a preceding article" do
        expect(first_article.has_preceding?).to be_false
      end

    end

  end

  context "succeeding articles" do

    let!(:first_article)  { Fabricate :article, created_at: 3.days.ago }
    let!(:second_article) { Fabricate :article, created_at: 2.days.ago }
    let!(:unpublished)    { Fabricate :article, created_at: 1.day.ago, published: false }

    describe "#succeeding" do

      it "can find a succeeding article" do
        expect(first_article.succeeding).to eq second_article
      end

      it "can't find a succeeding article" do
        expect(second_article.succeeding).to be_nil
      end

    end

    describe "#has_succeeding?" do

      it "knows when there is a succeeding article" do
        expect(first_article.has_succeeding?).to be_true
      end

      it "knows when there isn't a succeeding article" do
        expect(second_article.has_succeeding?).to be_false
      end

    end

  end

  describe ".published_without" do

    context "when there is only one article" do

      let!(:article) { Fabricate :article }

      it "there is nothing to read when excluding the only article" do
        expect(described_class.published_without(article)).to be_empty
      end

    end

    context "when there are multiple articles" do

      let!(:article) { Fabricate :article }
      let!(:latest)  { Fabricate :article }

      it "there is an article to read when excluding the latest article" do
        expect(described_class.published_without(article)).to eq [ latest ]
      end

    end

  end

  describe ".published" do

    context "when there are no articles" do

      it "there is nothing to read" do
        expect(described_class.published).to be_empty
      end

    end

    context "when there are no published articles" do

      let!(:article) { Fabricate :article, published: false }

      it "there is nothing to read" do
        expect(described_class.published).to be_empty
      end

    end

    context "when there is a published article" do

      let!(:article) { Fabricate :article }

      it "there is an article to read" do
        expect(described_class.published).to eq [ article ]
      end

    end

  end

  describe ".tagged_with" do

    let!(:tag) { Fabricate :tag }

    context "when there is an article tagged with the specified tag" do

      let!(:article) { Fabricate :article, tags: [ tag ] }

      it "finds an article" do
        expect(described_class.tagged_with(tag)).not_to be_empty
      end

    end

    context "when there isn't an article tagged with the specified tag" do

      let!(:article) { Fabricate :article }

      it "doesn't find an article" do
        expect(described_class.tagged_with(tag)).to be_empty
      end

    end

  end

end
