class ToppagesController < ApplicationController
  def index
    if logged_in?
      @book = current_user.books.build
      @books = current_user.feed_books.order(id: :desc).page(params[:page])
    end
  end
end
