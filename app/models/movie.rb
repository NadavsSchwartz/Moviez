class Movie < ApplicationRecord
	belongs_to :user
	has_many :reviews

  def self.get_movie(params)
    res = HTTParty.get("http://www.omdbapi.com/?t=#{params}&apikey=78c60231")
  end
end
