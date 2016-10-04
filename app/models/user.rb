class User < ApplicationRecord
    has_many :blogs
    has_many :comments

    has_secure_password

    validates_uniqueness_of :email
end
