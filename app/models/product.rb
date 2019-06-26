class Product < ApplicationRecord

  has_many :members
	has_many :taggings
	has_many :tags, through: :taggings

  after_create :fetch_gems

  private

  def fetch_gems
    GemTagger.new(product: self, interface: FetchGems).tag if github_repository_url.present?
  end

end
