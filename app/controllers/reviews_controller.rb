class ReviewsController < ApplicationController
  before_action :get_movie, except: [:latest]
  before_action :get_review, only: %i[edit destroy]
  skip_before_action :redirect_if_logged_out, only: %i[index latest], raise: false

  def index
    @reviews = if params[:user_id]
                 @movie.reviews_by(User.find(params[:user_id]))
               else
                 @movie.reviews.last(3)
                end
  end

  def new
    @review = @movie.reviews.new
  end

  def edit
    @review = get_review
  end

  def create
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
    if @movie.reviews.update(review_params)
      redirect_to movie_user_reviews_path(@movie.id, current_user), notice: 'Review updated successfully.'
    else
      render :edit
    end
  end

  def destroy
    @reviews.destroy
    redirect_to root_path, notice: 'Review deleted successfully.'
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
