class BooksController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:destroy]
  
  def show
  end
  
  def create
    @book = current_user.books.build(book_params)
    if @book.save
      flash[:success] = '本を投稿しました。'
      redirect_to root_url
    else
      @books = current_user.books.order(id: :desc).page(params[:page])
      flash.now[:danger] = '本の投稿に失敗しました。'
      render 'toppages/index'
    end
  end

  def destroy
    @book.destroy
    flash[:success] = '本を削除しました。'
    redirect_back(fallback_location: root_path)
  end
  
  private
  
  def book_params
    params.require(:book).permit(:image, :name, :genre, :content)
  end
  
  def correct_user
    @book = current_user.books.find_by(id: params[:id])
    unless @book
      redirect_to root_url
    end
  end
end

