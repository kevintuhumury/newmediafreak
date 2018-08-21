class Tag < ApplicationRecord
  extend FriendlyId

  friendly_id :name, use: :slugged

  has_and_belongs_to_many :articles

  validates :name, presence: true, uniqueness: true

  def frequency
    articles.count
  end

  protected

  def should_generate_new_friendly_id?
    new_record?
  end

end
