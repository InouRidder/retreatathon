class QueryProducts
  attr_reader :params, :collection

  def initialize(attributes)
    @params = attributes[:params]
    @collection = attributes[:collection] || Product.all
  end

  def call
    @collection = filter_by_tags(params[:tags], @collection) if params[:tags] && !params[:tags].blank?
    @collection = filter_by_queries(params[:queries], @collection) if params[:queries] && !params[:queries].blank?
    @collection
  end

  private

  def filter_by_tags(tags, collection)
    collection.search(tags)
  end

  def filter_by_queries(queries, collection)
    # # In case of searching by one query OR other query
    results = []
    if queries.is_a? Array
      queries.each do |query|
        results << collection.search(query)
      end
      results.flatten
    else
      collection.search(queries)
    end
  end
end
