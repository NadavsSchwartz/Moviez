class User < ApplicationRecord
  has_secure_password
  validates_presence_of :email, :name
  validates_uniqueness_of :email, { case_sensitive: false }
  has_many :reviews
  has_many :movies, -> { distinct }, through: :reviews

  def self.find_or_create_with_oauth(auth)
    u = User.find_by_uid(auth['uid']) || User.find_or_create_by_email(auth)
    u.email = auth['info']['email']
    u.uid = auth['uid']
    u.save
    u
end

  def self.find_or_create_by_email(auth)
    User.find_or_create_by(email: auth['info']['email']) do |u|
      u.uid = auth['uid']
      u.password = SecureRandom.hex(20)
      u.name = auth['info']['name']
    end
end
end
