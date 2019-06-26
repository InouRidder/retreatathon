class Product < ApplicationRecord
	has_many :taggings
	has_many :tags, through: :taggings
  
  include PgSearch
  pg_search_scope :global_search,
    against:[  
						 :name,
						 :customer_segment,
						 :tagline,
						 :pain,
						 :solution,
						 :user_core_journey,
						 :originality,
						],
		associated_against: {
			tag: [:title],
		},
    using: {
      tsearch: { prefix: true }
    }
end

