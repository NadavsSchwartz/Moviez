class MoviesController < ApplicationController
  skip_before_action :redirect_if_logged_out, only: %i[index find]

  def index
    if (params["user_id"])
      @user = User.find(params["user_id"])
      @movies = @user.movies
    else
      @movies = Movie.last(12)
    end
  end

  def new; end

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
      render :show
    end
  end

  def edit; end

  def find
    @movie = find_movie
    if @movie.nil? || @movie.title.nil?
      flash.alert = 'No movie found with this id'
      redirect_to root_path
    else
      @reviewers = @movie.reviewers
      render :show
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
