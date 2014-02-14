class StoreController < ApplicationController
  def index
    @products = Product.order(:title)
    @time = current_time
  end
end
