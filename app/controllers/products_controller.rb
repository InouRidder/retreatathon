class ProductsController < ApplicationController
  skip_before_action :authenticate_user!
  
  def autocomplete
    render json: {
      products: QueryProducts.new({ params: { queries: [params[:q]] } }).call.map(&:name)
    }
  end

  private

end
