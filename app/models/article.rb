class Article < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: [ :slugged, :history ]

  has_and_belongs_to_many :tags
  belongs_to :author
  belongs_to :category, optional: true

  validate :slug_must_be_valid

  scope :published, -> { where.not(published_at: nil).where("published_at <= ?", Time.zone.now) }
  scope :by_published_at, -> { order(published_at: :desc) }
  scope :with_tags, -> { includes(:tags) }
  scope :with_category, -> { includes(:category) }
  scope :by_year, ->(year) {
    start_of_year = Date.new(year, 1, 1).beginning_of_day
    end_of_year = Date.new(year, 12, 31).end_of_day
    where(published_at: start_of_year..end_of_year) # Replace :created_at with your date column
  }

  before_destroy :remove_tags

  def published?
    published_at.present? && published_at <= Time.zone.now
  end


  def summary
    ActionView::Base.full_sanitizer.sanitize(content_html).truncate(200)
  end

  def self.get_years
    published
    .select("DISTINCT EXTRACT(YEAR FROM published_at) AS year")
    .order("year DESC")
    .map { |r| r.year.to_i }
  end

  private

  def slug_must_be_valid
    if ENV["FORBIDDEN_SLUG"].split(",").include?(slug)
      errors.add(:slug, "#{slug} is not a valid slug")
    end
  end

  def remove_tags
    tags.clear
  end
end
