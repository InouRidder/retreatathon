class Product < ApplicationRecord
  has_many :members
	has_many :taggings
	has_many :tags, through: :taggings
  SEARCHABLE_ATTR = [:name, :customer_segment, :tagline, :pain, :solution, :user_core_journey, :originality, :batch]

  include PgSearch
  pg_search_scope :search,
    against: SEARCHABLE_ATTR,
		associated_against: {
			tags: [:title],
      members: [:first_name, :last_name]
		},
    using: {
      tsearch: { prefix: true }
    }

  # TODO: Into job
  after_create :fetch_gems, :taggify

  private

  def fetch_gems
    GemTagger.new(product: self, interface: FetchGems).tag if github_repository_url.present?
  end

  def taggify
    Taggifyer.new(self).run
  end
end
