class QueryProducts
  attr_reader :params, :collection

  def initialize(attributes)
    @params = attributes[:params]
    @collection = attributes[:collection] || Product.all
  end

  def call
    new_collection = filter_by(@params, @collection) # if params[:tags]
  end

  private

  def filter_by(filters, collection)
    # In case of searching by gem AND another gem
    # filter = filters.join(" ")
    # collection.search(filter)

    # In case of searching by one gem OR other gem
    results = []
    filters.each do |filter|
      results << collection.search(filter)
    end
    results.flatten
  end
end
