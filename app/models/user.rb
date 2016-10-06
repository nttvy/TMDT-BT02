class User < ApplicationRecord
    has_many :blogs
    has_many :comments
    mount_uploader :image, ImageUploader
    has_secure_password

    validates_uniqueness_of :email

    def self.from_omniauth(auth)
        where(email: auth.email).first_or_create do |user|
            user.firstname = auth.info.name
            user.email = auth.info.email
            user.password_digest = auth.extra.access_token.token
            user.save
        end
    end

end
