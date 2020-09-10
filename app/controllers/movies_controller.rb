class MoviesController < ApplicationController
    def new
    @movie = Movie.new
    render :new
  end

  def show
    @movie = Movie.find(params[:id])
  end

  def create
    binding.pry
  end
end
