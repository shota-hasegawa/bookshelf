class RankingsController < ApplicationController
  before_action :require_user_logged_in
  
  def index
    @books = Book.order("average DESC").limit(10)
  end
end
