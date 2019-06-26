class Product < ApplicationRecord
  has_many :members
	has_many :taggings
	has_many :tags, through: :taggings
end
