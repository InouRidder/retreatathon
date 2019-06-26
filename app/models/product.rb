class Product < ApplicationRecord

  has_many :members
	has_many :taggings
	has_many :tags, through: :taggings

  include PgSearch
  pg_search_scope :search,
    against:[
						 :name,
						 :customer_segment,
						 :tagline,
						 :pain,
						 :solution,
						 :user_core_journey,
						 :originality,
						 :gems
						],
		associated_against: {
			tags: [:title],
		},
    using: {
      tsearch: { prefix: true }
    }

  #after_create :fetch_gems

  private

  def fetch_gems
    GemTagger.new(product: self, interface: FetchGems).tag if github_repository_url.present?
  end

end
