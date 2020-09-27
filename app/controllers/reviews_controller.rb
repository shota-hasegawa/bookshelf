class ReviewsController < ApplicationController
  before_action :require_user_logged_in
  
  def index
    @book = Book.find(params[:book_id])
    @reviews = @book.reviews
  end

  def create
    @review = current_user.reviews.build(review_params)
    @book = @review.book
  
    if @review.save
      flash[:success] = 'レビューを投稿しました。'
      redirect_to book_path(@review.book)
    else
      flash.now[:danger] = 'レビューの投稿に失敗しました。'
      render 'books/show'
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


