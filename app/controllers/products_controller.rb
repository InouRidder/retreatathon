class ProductsController < ApplicationController
  def index
    if query_params
      @products = QueryProducts.new(query_params)
    else
      @products = Product.all
    end
  end

  private

  def query_params
    @parameters ||= params[:query]
  end
end
