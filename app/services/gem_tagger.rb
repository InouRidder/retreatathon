require "ostruct"
require_relative 'fetch_gems' # TODO: Remove!

class GemTagger
  attr_accessor :project, :gem_fetcher
  attr_reader :gems

  def initialize(attributes)
    @project = attributes[:project]
    @gem_fetcher = attributes[:gem_fetcher]
  end

  def tag
    @gems ||= gem_fetcher.fetch(project.github_repository_url)
    project.gems = gems
    project.save
  end
end


# p GemTagger.new(project: OpenStruct.new(url: 'https://github.com/ClementLaussucq/hife', gems: []), gem_fetcher: FetchGems).tag
# Usage: replace OpenStruct in the example above with a project.
