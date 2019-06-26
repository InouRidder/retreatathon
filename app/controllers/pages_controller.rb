class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
    @number_of_products = Product.all.length

    if query_params
      @products = QueryProducts.new({ params: query_params }).call
    else
      @products = Product.all
    end
    @products = Kaminari.paginate_array(@products).page(params[:page]).per(12)
  end

  private

  def query_params
    params.permit(:queries, :tags)
  end
end
