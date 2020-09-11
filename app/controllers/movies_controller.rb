class MoviesController < ApplicationController
  def new
    @movie = Movie.new
end

  def show
    @movie = Movie.find_by(title: params[:search].capitalize)
    @movie = Movie.get_movie(params[:search]) if @movie.nil?
      if !!@movie['Error']
        flash.notice = 'Movie not found. Please try again with a better description'
        redirect_to movie_search_path
    else
      render :test if create(@movie)
    end
  end

  private

  def create(res)
    movie = Movie.find_or_create_by(
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
  end
end
