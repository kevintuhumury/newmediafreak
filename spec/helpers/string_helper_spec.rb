require "spec_helper"

describe StringHelper do

  context "#shorten" do

    it "removes HTML tags" do
      description = "<h1>foo</h1>"
      helper.shorten(description).should eq "foo"
    end

    it "truncates the full description" do
      description = "Nullam quis risus eget urna mollis ornare vel eu leo. Aenean lacinia bibendum nulla sed consectetur. Nulla vitae elit libero, a pharetra augue. Vivamus sagittis lacus vel augue laoreet rutrum faucibus dolor auctor. Vestibulum id ligula porta felis euismod semper. Etiam porta sem malesuada magna mollis euismod. Etiam porta sem malesuada magna mollis euismod. Aenean eu leo quam. Pellentesque ornare sem lacinia quam venenatis vestibulum. Duis mollis, est non commodo luctus, nisi erat porttitor ligula, eget lacinia odio sem nec elit."
      helper.shorten(description).should eq "Nullam quis risus eget urna mollis ornare vel eu leo. Aenean lacinia bibendum nulla sed consectetur. Nulla vitae elit libero, a pharetra augue. Vivamus sagittis lacus vel augue laoreet rutrum faucibus dolor auctor. Vestibulum id ligula porta felis euismod semper. Etiam porta sem malesuada magna mollis euismod. Etiam porta sem malesuada magna mollis euismod. Aenean eu leo quam. Pellentesque orna..."
    end

    it "removes consecutive white-space" do
      description = "foo   bar \t baz"
      helper.shorten(description).should eq "foo bar baz"
    end

    it "creates a single line out of a multi-line description" do
      description = "foo \n bar"
      helper.shorten(description).should eq "foo bar"
    end

  end

end
