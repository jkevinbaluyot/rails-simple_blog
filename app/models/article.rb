class Article < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged

  has_and_belongs_to_many :tags
  belongs_to :author
  belongs_to :category, optional: true

  before_validation :generate_slug

  validate :slug_must_be_valid

  scope :published, -> { where.not(published_at: nil).where("published_at <= ?", Time.zone.now) }
  scope :with_tags, -> { includes(:tags) }
  scope :with_category, -> { includes(:category) }

  before_destroy :remove_tags

  def published?
    published_at.present? && published_at <= Time.zone.now
  end

  def summary
    ActionView::Base.full_sanitizer.sanitize(content_html).truncate(200)
  end

  private

  def generate_slug
    self.slug = title.parameterize if title.present?
  end

  def slug_must_be_valid
    if ENV["FORBIDDEN_SLUG"].split(",").include?(slug)
      errors.add(:slug, "#{slug} is not a valid slug")
    end
  end

  def remove_tags
    tags.clear
  end
end
