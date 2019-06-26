class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
    @products = Product.all.where(batch_number: (200..250).to_a)
  end
end
