class Product < ApplicationRecord
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
		associated_against: {},
    using: {
      tsearch: { prefix: true }
    }
end