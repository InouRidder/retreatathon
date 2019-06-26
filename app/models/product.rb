class Product < ApplicationRecord

  after_create :fetch_gems

  private

  def fetch_gems
    GemTagger.new(project: self, interface: FetchGems).tag if project.github_repository_url.present?
  end
end
