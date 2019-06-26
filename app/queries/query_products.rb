class QueryProducts
  attr_reader :params, :collection

  def initialize(attributes)
    @params = attributes[:params]
    @collection = attributes[:collection] || Product.all
  end

  def call
    @collection = filter_by_tags(params[:tags], collection) if params[:tags]
    @collection
  end

  private

  def filter_by_tags(tags, collection)
  end

end
