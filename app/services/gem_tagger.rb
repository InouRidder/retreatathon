require "ostruct"

class GemTagger
  attr_accessor :product, :gem_fetcher
  attr_reader :gems

  def initialize(attributes)
    @product = attributes[:product]
    @gem_fetcher = attributes[:gem_fetcher]
  end

  def tag
    @gems ||= gem_fetcher.fetch(product.github_repository_url)
    product.gems = gems
    product.save
  end
end


# p GemTagger.new(project: OpenStruct.new(url: 'https://github.com/ClementLaussucq/hife', gems: []), gem_fetcher: FetchGems).tag
# Usage: replace OpenStruct in the example above with a project.
