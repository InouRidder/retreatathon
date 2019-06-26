class QueryProducts
  attr_reader :params, :collection

  def initialize(attributes)
    @params = attributes[:params]
    @collection = attributes[:collection] || Product.all
  end

  def call
    @collection = filter_by_tags(params[:tags], collection) if params[:tags]
    @collection = filter_by_gems(params[:gems], collection) if params[:gems]
    @collection
  end

  private

  def filter_by_tags(tags, collection)
  end

  def filter_by_gems(gems, collection)
  end
end
