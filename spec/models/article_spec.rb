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
      subject.preceding.should be_nil
    end

    it "there is no succeeding article" do
      subject.succeeding.should be_nil
    end

  end

  context "when there are two articles" do

    let!(:first_article)  { Fabricate :article, created_at: 2.days.ago }
    let!(:second_article) { Fabricate :article, created_at: Date.today }
    let!(:unpublished)    { Fabricate :article, created_at: 1.day.ago, published: false }

    context "when the first article is selected" do

      subject { first_article }

      it "there is no preceding article" do
        subject.preceding.should be_nil
      end

      it "there is a succeeding article" do
        subject.succeeding.should eq second_article
      end

    end

    context "when the second article is selected" do

      subject { second_article }

      it "there is a preceding article" do
        subject.preceding.should eq first_article
      end

      it "there is no succeeding article" do
        subject.succeeding.should be_nil
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
        subject.preceding.should be_nil
      end

      it "there is a succeeding article" do
        subject.succeeding.should eq second_article
      end

    end

    context "when the second article is selected" do

      subject { second_article }

      it "there is a preceding article" do
        subject.preceding.should eq first_article
      end

      it "there is a succeeding article" do
        subject.succeeding.should eq third_article
      end

    end

    context "when the third article is selected" do

      subject { third_article }

      it "there is a preceding article" do
        subject.preceding.should eq second_article
      end

      it "there is no succeeding article" do
        subject.succeeding.should be_nil
      end

    end

  end

  context "preceding articles" do

    let!(:first_article)  { Fabricate :article, created_at: 3.days.ago }
    let!(:second_article) { Fabricate :article, created_at: 2.days.ago }
    let!(:unpublished)    { Fabricate :article, created_at: 4.day.ago, published: false }

    describe "#preceding" do

      it "can find a preceding article" do
        second_article.preceding.should eq first_article
      end

      it "can't find a preceding article" do
        first_article.preceding.should be_nil
      end

    end

    describe "#has_preceding?" do

      it "knows when there is a preceding article" do
        second_article.has_preceding?.should be_true
      end

      it "knows when there isn't a preceding article" do
        first_article.has_preceding?.should be_false
      end

    end

  end

  context "succeeding articles" do

    let!(:first_article)  { Fabricate :article, created_at: 3.days.ago }
    let!(:second_article) { Fabricate :article, created_at: 2.days.ago }
    let!(:unpublished)    { Fabricate :article, created_at: 1.day.ago, published: false }

    describe "#succeeding" do

      it "can find a succeeding article" do
        first_article.succeeding.should eq second_article
      end

      it "can't find a succeeding article" do
        second_article.succeeding.should be_nil
      end

    end

    describe "#has_succeeding?" do

      it "knows when there is a succeeding article" do
        first_article.has_succeeding?.should be_true
      end

      it "knows when there isn't a succeeding article" do
        second_article.has_succeeding?.should be_false
      end

    end

  end

  describe ".published_without" do

    context "when there is only one article" do

      let!(:article) { Fabricate :article }

      it "there is nothing to read when excluding the only article" do
        Article.published_without(article).should be_empty
      end

    end

    context "when there are multiple articles" do

      let!(:article) { Fabricate :article }
      let!(:latest)  { Fabricate :article }

      it "there is an article to read when excluding the latest article" do
        Article.published_without(article).should eq [ latest ]
      end

    end

  end

  describe ".published" do

    context "when there are no articles" do

      it "there is nothing to read" do
        Article.published.should be_empty
      end

    end

    context "when there are no published articles" do

      let!(:article) { Fabricate :article, published: false }

      it "there is nothing to read" do
        Article.published.should be_empty
      end

    end

    context "when there is a published article" do

      let!(:article) { Fabricate :article }

      it "there is an article to read" do
        Article.published.should eq [ article ]
      end

    end

  end

  describe ".tagged_with" do

    let!(:tag) { Fabricate :tag }

    context "when there is an article tagged with the specified tag" do

      let!(:article) { Fabricate :article, tags: [ tag ] }

      it "finds an article" do
        Article.tagged_with(tag).should_not be_empty
      end

    end

    context "when there isn't an article tagged with the specified tag" do

      let!(:article) { Fabricate :article }

      it "doesn't find an article" do
        Article.tagged_with(tag).should be_empty
      end

    end

  end

end
