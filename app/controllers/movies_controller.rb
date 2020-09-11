class MoviesController < ApplicationController
  #using the private method "find movie on any routes that contain 'id' for 'dry' code"
    # before_action :find_movie, only: [:show, :edit, :update, :destroy]

  #making sure user has to be logged in unless user is at index or show routes
    # before_action :authenticate_user!, except: [:index, :show]


  def index
    @movies = Movie.last(6)
  end

  def new
    @movie = current_user.movies.new
  end

  def search
    render :search
  end

  def show
    movie = Movie.find_by(title: params[:search].capitalize) if params[:search].present?
    movie = Movie.get_movie(params[:search]) if movie.nil?
    if movie['Error']
    flash.notice = 'Movie could not be found. Please try again with more details'
      redirect_to movie_search_path
    else
      binding.pry
      @new_movie = create_movie(movie)
      redirect_to (@new_movie)
    end
  end

  def edit
  end

  private

  def find_movie
    @movie = Movie.find(params[:id])
  end

  def movie_params
    params.require(:movie).permit(:title, :year, :write, :director, :rated, :genre, :actors, :awards, :runtime, :plot, :poster, :ratings)
  end

  def create_movie(res)
    @new_movie = current_user.movies.new(
      title: res['Title'],
      year: res['Year'],
      rated: res['Rated'],
      genre: res['Genre'],
      write: res['Writer'],
      actors: res['Actors'],
      awards: res['Awards'],
      runtime: res['Runtime'],
      plot: res['Plot'],
      poster: res['Poster'],
      ratings: res['imdbRating']
    )
    @new_movie.save
  end
end
