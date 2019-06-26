class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
    products = Product.all
    @products = Kaminari.paginate_array(products).page(params[:post_page]).per(12)
  end
end
