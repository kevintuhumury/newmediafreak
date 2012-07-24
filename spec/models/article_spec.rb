require 'spec_helper'

describe Article do

  it { should deny(:title).to_be_blank }
  it { should deny(:content).to_be_blank }
  it { should deny(:image).to_be_blank }

  context "when there is only a single article" do

    subject { Fabricate :article, created_at: 1.day.ago.to_datetime }

    before do
      @unpublished_before = Fabricate :article, created_at: 4.days.ago.to_datetime, published: false
      @unpublished_after  = Fabricate :article, created_at: Date.today.to_datetime, published: false
    end

    it "there is no previous article" do
      subject.previous.should be_nil
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

      it "there is no previous article" do
        subject.previous.should be_nil
      end

      it "there is a next article" do
        subject.upcoming.should eq @second_article
      end

    end

    context "when the second article is selected" do
      subject { @second_article }

      it "there is a previous article" do
        subject.previous.should eq @first_article
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

      it "there is no previous article" do
        subject.previous.should be_nil
      end

      it "there is a next article" do
        subject.upcoming.should eq @second_article
      end

    end

    context "when the second article is selected" do

      subject { @second_article }

      it "there is a previous article" do
        subject.previous.should eq @first_article
      end

      it "there is a next article" do
        subject.upcoming.should eq @third_article
      end

    end

    context "when the third article is selected" do

      subject { @third_article }

      it "there is a previous article" do
        subject.previous.should eq @second_article
      end

      it "there is no next article" do
        subject.upcoming.should be_nil
      end

    end

  end

  describe "#has_previous?" do

    before do
      @unpublished    = Fabricate :article, created_at: 4.day.ago, published: false
      @first_article  = Fabricate :article, created_at: 3.days.ago
      @second_article = Fabricate :article, created_at: 2.days.ago
    end

    it "can find a previous article" do
      @second_article.previous.should eq @first_article
    end

    it "can't find a previous article" do
      @first_article.previous.should be_nil
    end

  end

  describe "#has_upcoming?" do

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
end
