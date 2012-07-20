class Article < ActiveRecord::Base

  extend FriendlyId

  friendly_id :title, use: :slugged

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

  def should_generate_new_friendly_id?
    new_record?
  end

  private

  def ordered
    Article.order("created_at DESC")
  end
end
