class Product < ApplicationRecord

  has_many :members
	has_many :taggings
	has_many :tags, through: :taggings
  SEARCHABLE_ATTR = [:name, :customer_segment, :tagline, :pain, :solution, :user_core_journey, :originality]

  include PgSearch
  pg_search_scope :search,
    against: SEARCHABLE_ATTR,
		associated_against: {
			tags: [:title],
		},
    using: {
      tsearch: { prefix: true }
    }

  after_create :fetch_gems, :taggify

  private

  def fetch_gems
    GemTagger.new(product: self, interface: FetchGems).tag if github_repository_url.present?
  end

  def taggify
    Taggifyer.new(self).run
  end

end
