class ProductsController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    @number_of_products = Product.all.length
    if query_params
      @products = QueryProducts.new({ params: query_params }).call
    else
      @products = Product.all
    end
    @products = Kaminari.paginate_array(@products).page(params[:page]).per(12)

    respond_to do |format|
      format.html
      format.js
    end
  end

  def autocomplete
    render json: {
      products: QueryProducts.new({ params: { queries: [params[:q]] } }).call.map(&:name)
    }
  end

  private


  private

  def query_params
    params.permit(:queries, :tags)
  end

end
