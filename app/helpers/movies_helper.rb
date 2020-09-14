module MoviesHelper
  def pic_available?
    !(@movie.poster.size < 4)
  end
end
