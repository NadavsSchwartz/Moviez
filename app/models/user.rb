class User < ApplicationRecord
  has_secure_password
  validates_presence_of :email, :name
  validates_uniqueness_of :email, { case_sensitive: false }
  has_many :reviews, through: :movies
  has_many :movies
end
