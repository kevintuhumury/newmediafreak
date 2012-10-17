require "spec_helper"

describe Article do

  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:content) }
  it { should validate_presence_of(:image) }

  context "when there is only a single article" do

    subject { Fabricate :article, created_at: 1.day.ago }

    before do
      @unpublished_before = Fabricate :article, created_at: 4.days.ago, published: false
      @unpublished_after  = Fabricate :article, created_at: Date.today, published: false
    end

    it "there is no preceding article" do
      subject.preceding.should be_nil
    end

    it "there is no next article" do
      subject.upcoming.should be_nil
    end

  end

  context "when there are two articles" do

    before do
      @first_article  = Fabricate :article, created_at: 2.days.ago
      @unpublished    = Fabricate :article, created_at: 1.day.ago, published: false
      @second_article = Fabricate :article, created_at: Date.today
    end

    context "when the first article is selected" do

      subject { @first_article }

      it "there is no preceding article" do
        subject.preceding.should be_nil
      end

      it "there is a next article" do
        subject.upcoming.should eq @second_article
      end

    end

    context "when the second article is selected" do
      subject { @second_article }

      it "there is a preceding article" do
        subject.preceding.should eq @first_article
      end

      it "there is no next article" do
        subject.upcoming.should be_nil
      end

    end

  end

  context "when there are three or more articles" do

    before do
      @first_article  = Fabricate :article, created_at: 3.days.ago
      @second_article = Fabricate :article, created_at: 2.days.ago
      @unpublished    = Fabricate :article, created_at: 1.day.ago, published: false
      @third_article  = Fabricate :article, created_at: Date.today
    end

    context "when the first article is selected" do

      subject { @first_article }

      it "there is no preceding article" do
        subject.preceding.should be_nil
      end

      it "there is a next article" do
        subject.upcoming.should eq @second_article
      end

    end

    context "when the second article is selected" do

      subject { @second_article }

      it "there is a preceding article" do
        subject.preceding.should eq @first_article
      end

      it "there is a next article" do
        subject.upcoming.should eq @third_article
      end

    end

    context "when the third article is selected" do

      subject { @third_article }

      it "there is a preceding article" do
        subject.preceding.should eq @second_article
      end

      it "there is no next article" do
        subject.upcoming.should be_nil
      end

    end

  end

  describe "#preceding" do

    before do
      @unpublished    = Fabricate :article, created_at: 4.day.ago, published: false
      @first_article  = Fabricate :article, created_at: 3.days.ago
      @second_article = Fabricate :article, created_at: 2.days.ago
    end

    it "can find a preceding article" do
      @second_article.preceding.should eq @first_article
    end

    it "can't find a preceding article" do
      @first_article.preceding.should be_nil
    end

  end

  describe "#upcoming" do

    before do
      @first_article  = Fabricate :article, created_at: 3.days.ago
      @second_article = Fabricate :article, created_at: 2.days.ago
      @unpublished    = Fabricate :article, created_at: 1.day.ago, published: false
    end

    it "can find an upcoming article" do
      @first_article.upcoming.should eq @second_article
    end

    it "can't find an upcoming article" do
      @second_article.upcoming.should be_nil
    end

  end

  describe "#has_preceding?" do

    before do
      @unpublished    = Fabricate :article, created_at: 4.day.ago, published: false
      @first_article  = Fabricate :article, created_at: 3.days.ago
      @second_article = Fabricate :article, created_at: 2.days.ago
    end

    it "knows when there is a preceding article" do
      @second_article.has_preceding?.should be_true
    end

    it "knows when there isn't a preceding article" do
      @first_article.has_preceding?.should be_false
    end

  end

  describe "#has_upcoming?" do

    before do
      @first_article  = Fabricate :article, created_at: 3.days.ago
      @second_article = Fabricate :article, created_at: 2.days.ago
      @unpublished    = Fabricate :article, created_at: 1.day.ago, published: false
    end

    it "knows when there is an upcoming article" do
      @first_article.has_upcoming?.should be_true
    end

    it "knows when there isn't an upcoming article" do
      @second_article.has_upcoming?.should be_false
    end
  end

  describe ".published" do

    context "when there are no articles" do

      it "there is nothing to read" do
        Article.published.should be_empty
      end

    end

    context "when there are no published articles" do

      before { Fabricate :article, published: false }

      it "there is nothing to read" do
        Article.published.should be_empty
      end

    end

    context "when there is a published article" do

      before { @article = Fabricate :article }

      it "there is an article to read" do
        Article.published.should eq [ @article ]
      end

    end

  end

  describe ".published_without" do

    context "when there is only one article" do

      before { @article = Fabricate :article }

      it "there is nothing to read when excluding the only article" do
        Article.published_without(@article).should be_empty
      end

    end

    context "when there are multiple articles" do

      before do
        @article = Fabricate :article
        @latest  = Fabricate :article
      end

      it "there is an article to read when excluding the latest article" do
        Article.published_without(@article).should eq [@latest]
      end

    end
  end

end
