class Movie < ApplicationRecord
	has_many :users
  has_many :reviews
  validates_uniqueness_of :title
  

  def self.get_movie(params)
    res = HTTParty.get("http://www.omdbapi.com/?t=#{params}&apikey=78c60231")
  end
end
