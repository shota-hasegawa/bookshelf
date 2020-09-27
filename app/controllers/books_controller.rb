class BooksController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:edit, :update, :destroy]
  
  def show
    @book = Book.find(params[:id])
    @user = @book.user
    @review = current_user.reviews.build
  end
  
  def new
    @book = current_user.books.build
  end
  
  def create
    @book = current_user.books.build(book_params)
    if @book.save
      flash[:success] = '本を投稿しました。'
      redirect_to root_url
    else
      @books = current_user.feed_books.order(id: :desc).page(params[:page])
      flash.now[:danger] = '本の投稿に失敗しました。必須項目が未入力です'
      render 'toppages/index'
    end
  end
  
  def edit
  end
  
  def update
    
    if @book.update(book_params)
      flash[:success] = '本は正常に更新されました。'
      redirect_to @book
    else
      flash.now[:danger] = '本は更新されませんでした。'
      render :edit
    end
  end

  def destroy
    @book.destroy
    flash[:success] = '本を削除しました。'
    redirect_to root_url
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

