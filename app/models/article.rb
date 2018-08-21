class Article < ApplicationRecord
  extend FriendlyId

  friendly_id :title, use: :slugged

  has_and_belongs_to_many :tags

  validates :title, :content, :image, presence: true

  def self.published_without(current)
    published.reject { |article| article == current }
  end

  def self.tagged_with(tag)
    published.select { |article| article.tags.include? tag }
  end

  def self.published
    ordered.where published: true
  end

  def preceding
    self.class.published.where.not(id: self.id).where("created_at < ?", created_at).first
  end

  def succeeding
    self.class.published.where.not(id: self.id).where("created_at > ?", created_at).last
  end

  def has_preceding?
    !preceding.blank?
  end

  def has_succeeding?
    !succeeding.blank?
  end

  private

  def self.ordered
    order(created_at: :desc)
  end

  protected

  def should_generate_new_friendly_id?
    new_record?
  end

end
