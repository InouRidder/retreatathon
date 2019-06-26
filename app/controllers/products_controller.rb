class ProductsController < ApplicationController
  skip_before_action :authenticate_user!
  
  def index
    if query_params
      @products = QueryProducts.new(query_params)
    else
      @products = Product.all
    end
  end

  def autocomplete
    render json: {
      products: QueryProducts.new({ params: params[:q] }).call.pluck(:name)
    }
  end

  private

  def query_params
    @parameters ||= params[:query]
  end
end
