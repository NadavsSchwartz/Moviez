class ReviewsController < ApplicationController
  def new
    @review = Review.new
  end

  def edit; end

  def create
    @review = Review.new(review_params)
    @review.user_id = current_user.id
    @review.movie_id = @movie.id

    if @review.save
      redirect_to @movie
    else
      render 'new'
    end
  end

  def update
    if @review.update(review_params)
      redirect_to @review, notice: 'Review updated successfully.'
      render :show
    else
      render :edit
    end
  end

  def destroy
    @review.destroy
    redirect_to reviews_url, notice: 'Review deleted successfully.'
  end

  private

  def get_review
    @review = Review.find(params[:id])
  end

  def get_movie
    @movie = Movie.find(params[:movie_id])
  end

  def review_params
    params.require(:review).permit(:rating, :comment)
  end
end
