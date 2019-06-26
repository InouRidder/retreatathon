class QueryProducts
  attr_reader :params, :collection

  def initialize(attributes)
    @params = attributes[:params]
    @collection = attributes[:collection] || Product.all
  end

  def call
    @collection = filter_by_tags(params[:tags], @collection) if params[:tags]
    @collection = filter_by_queries(params[:queries], @collection) if params[:queries]
    @collection
  end

  private

  def filter_by_tags(tags, collection)
    tag = tags.join(" ")
    collection.search(tag)
  end

  def filter_by_queries(queries, collection)
    # if !filters.blank?
    #   filters = filters.join(" ") if filters.respond_to?(:join)
    #   collection.search(filters)
    # else
    #   collection.all
    # end
    
    # # In case of searching by one query OR other query
    results = []
    queries.each do |query|
      results << collection.search(query)
    end
    results.flatten
  end

end
