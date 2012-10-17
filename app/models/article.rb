class Article < ActiveRecord::Base

  extend FriendlyId

  friendly_id :title, use: :slugged

  attr_accessible :title, :content, :image
  validates_presence_of :title, :content, :image

  def self.published_without(current)
    published.reject { |article| article == current }
  end

  def self.published
    ordered.where(published: true)
  end

  def preceding
    self.class.published.where("created_at < ?", created_at).first
  end

  def succeeding
    self.class.published.where("created_at > ?", created_at).last
  end

  def has_preceding?
    !preceding.blank?
  end

  def has_succeeding?
    !succeeding.blank?
  end

  private

  def self.ordered
    order("created_at DESC")
  end

  protected

  def should_generate_new_friendly_id?
    new_record?
  end

end
