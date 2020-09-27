class ReviewsController < ApplicationController
  before_action :require_user_logged_in
  
  def index
    @book = Book.find(params[:book_id])
    @review = current_user.reviews.build
    @reviews = @book.reviews.order(id: :desc).page(params[:page]).per(25)
  end

  def create
    @review = current_user.reviews.build(review_params)
    @book = @review.book
  
    if @review.save
      flash[:success] = 'レビューを投稿しました。'
      redirect_to book_path(@review.book)
    else
      @reviews = @book.reviews.order(id: :desc).page(params[:page]).per(25)
      flash.now[:danger] = 'レビューの投稿に失敗しました。必須項目が未入力です。'
      render :index
    end
    
    evaluations = @book.reviews.pluck(:evaluation)
    unless @book.average
      review_average = @review.evaluation
    else
      review_average = evaluations.reduce(:+) / evaluations.size.to_f
    end
    @book.update(average: review_average)
  end
  
  
  private
  
  def review_params
    params.require(:review).permit(:book_id, :content, :evaluation)
  end
  
end


