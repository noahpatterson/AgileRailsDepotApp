module VisitCount
  extend ActiveSupport::Concern

  private

  def visit_count_reset
    session[:counter] = 0
  end
end