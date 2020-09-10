class User < ApplicationRecord
    has_secure_password
    validates :password, length: { in: 6..72 }
    validates_presence_of :email, :name
    validates_uniqueness_of :email, { case_sensitive: false }
end
