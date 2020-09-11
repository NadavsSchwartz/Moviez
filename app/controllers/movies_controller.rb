class MoviesController < ApplicationController
  # using the private method "find movie on any routes that contain 'id' for 'dry' code"
  # before_action :find_movie, only: [:show, :edit, :update, :destroy]

  # making sure user has to be logged in unless user is at index or show routes
  # before_action :authenticate_user!, except: [:index, :show]

  def index
    @movies = Movie.last(12)
    render :index
  end

  def new

  end

  def search
    render :search
  end

  def show
    @movie = Movie.find_by(title: params[:search].capitalize) if params[:search].present?
    if @movie.nil?
      @movie = Movie.get_movie(params[:search])
      if @movie['Error']
        flash.notice = "#{@movie['Error']} Youre query: #{params[:search]}, Please try again."
        redirect_to root_path
      else
        @movie = create_movie(@movie)
      end
    else
      render :test
    end
  end

  def edit; end

  def find
    @movie = find_movie
    if @movie.nil? || @movie.title.nil?
    flash.alert = "No movie found with this id"
    redirect_to root_path
    else
      render :test
    end
  end

  private

  def find_movie
    @movie = Movie.find_by(id: params[:id])
  end

  def create_movie(res)
    if logged_in
      movie = current_user.movies.build(
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
      
      if movie.save
        redirect_to movie_path(movie.id) 
      else
      movie = Movie.find_by(title: movie.title)
      redirect_to movie_path(movie.id) 
      end
  else
      movie = Movie.new(
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
    movie.save
    redirect_to movie_path(movie.id)
    end
  end
end
