class StoreController < ApplicationController
  def index
    @products = Product.order(:title)
    @time = current_time
    @count = count_visits
  end

  private

  def count_visits
    session[:counter] ||= 0
    session[:counter] += 1
  end
end
