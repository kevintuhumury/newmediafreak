require 'spec_helper'

describe ArticleHelper do

  let(:article) { double }

  context "when there are 5 articles" do

    subject { Array.new(5) { article } }

    it "there is a single page of articles in the carousel" do
      helper.find_pages_for(subject).should eq 1
    end

    it "there is 1 empty element to fill up the page" do
      helper.number_of_filler_elements_for(subject).should eq 1
    end

  end

  context "when there are 6 articles" do

    subject { Array.new(6) { article } }

    it "there is a single page of articles in the carousel" do
      helper.find_pages_for(subject).should eq 1
    end

    it "there are no empty elements to fill up the page" do
      helper.number_of_filler_elements_for(subject).should eq 0
    end

  end

  context "when there are 10 articles" do

    subject { Array.new(10) { article } }

    it "there are two pages in the carousel" do
      helper.find_pages_for(subject).should eq 2
    end

    it "there are two empty elements to fill up the second page" do
      helper.number_of_filler_elements_for(subject).should eq 2
    end

  end

  context "when there are 13 articles" do

    subject { Array.new(13) { article } }

    it "there are three pages in the carousel" do
      helper.find_pages_for(subject).should eq 3
    end

    it "there are five empty elements to fill up the third page" do
      helper.number_of_filler_elements_for(subject).should eq 5
    end

  end

end
