class Review < ApplicationRecord
has_many :users
has_many :movies, through: :users
end
