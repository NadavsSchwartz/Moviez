class Movie < ApplicationRecord
  has_many :reviews
  has_many :reviewers, through: :reviews, source: :user
  validates_uniqueness_of :title

  def self.order_by(type) 
    self.all.order(type)
  end

  def reviews_by(user)
    reviews.where(user: user)
  end

  def self.get_movie(params)
    res = HTTParty.get("http://www.omdbapi.com/?t=#{params}&apikey=78c60231")
  end
end
