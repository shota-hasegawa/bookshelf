class FavoritesController < ApplicationController
  before_action :require_user_logged_in
  
  def create
    book = Book.find(params[:book_id])
    current_user.favorite(book)
    flash[:success] = 'お気に入り登録しました。'
    redirect_back(fallback_location: root_path)
  end

  def destroy
    book = Book.find(params[:book_id])
    current_user.unfavorite(book)
    flash[:success] = 'お気に入りを解除しました。'
    redirect_back(fallback_location: root_path)
  end
end
