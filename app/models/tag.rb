class Tag < ApplicationRecord
	has_many :taggings
	has_many :products, through: :taggings

  validates :title, uniqueness: true

end
