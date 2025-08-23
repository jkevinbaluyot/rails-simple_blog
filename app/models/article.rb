class Article < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged

  before_validation :generate_slug

  validate :slug_must_be_valid

  private

  def generate_slug
    self.slug = title.parameterize if title.present?
  end

  def slug_must_be_valid
    if ENV["FORBIDDEN_SLUG"].split(",").include?(slug)
      errors.add(:slug, "#{slug} is not a valid slug")
    end
  end
end
