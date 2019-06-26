class GemTagger
  attr_accessor :project

  def initialize(attributes)
    @project = attributes[:project]
    return if project.github_repository_url.empty?
  end

  def tag
    # fetch_and_parse_gemfile
    # fetch_difference_to_base_gemfile_base
    # add_difference_as_tags
  end

end
