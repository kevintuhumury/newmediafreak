class Article < ActiveRecord::Base
  attr_accessible :title, :content, :image
  validates_presence_of :title, :content, :image

  def previous
    ordered.where("created_at < ?", created_at).first
  end

  def upcoming
    ordered.where("created_at > ?", created_at).last
  end

  def has_previous?
    !previous.blank?
  end

  def has_upcoming?
    !upcoming.blank?
  end

  private

  def ordered
    Article.order("created_at DESC")
  end
end
