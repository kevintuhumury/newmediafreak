class Article < ActiveRecord::Base
  attr_accessible :title, :content, :image
  validates_presence_of :title, :content, :image
end
