class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
    if query_params
      @products = QueryProducts.new(query_params)
      @products = Kaminari.paginate_array(@products).page(params[:post_page]).per(12)
    else
      @products = Product.all
      @products = Kaminari.paginate_array(@products).page(params[:post_page]).per(12)
    end
  end

  private

  def query_params
    @parameters ||= params[:query]
  end
end
