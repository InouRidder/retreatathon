class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
    @number_of_products = Product.all.length

    if query_params
      @products = QueryProducts.new(query_params).page(params[:page]).per(12)
    else
      @products = Product.page(params[:page]).per(12)
    end
  end

  private

  def query_params
    @parameters ||= params[:query]
  end
end
