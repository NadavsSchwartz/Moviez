class ReviewsController < ApplicationController
   skip_before_action :get_movie, only: [:latest], raise: false
  skip_before_action :redirect_if_logged_out, only: [:index], raise: false

  def index
    @movie = get_movie
    @review = @movie.reviews.last(3)
    @user = @use
  end

  def new
    @movie = get_movie
    @review = @movie.reviews.new
  end

  def edit; end

  def create
    @movie = get_movie
    @review = Review.new(review_params)
    @review.user_id = current_user.id
    @review.movie_id = @movie.id

    if @review.save
      redirect_to movie_reviews_path
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

  def latest
    @reviews = Review.last(6)
  end

  private

  def get_review
    @reviews = Review.find(params[:id])
  end

  def get_movie
    @movie = Movie.find(params[:movie_id]) || Movie.find(params[:movie_id])
  end

  def review_params
    params.require(:review).permit(:rating, :comment)
  end
end
