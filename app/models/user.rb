class User < ApplicationRecord
    has_many :blogs
    has_many :comments
    has_many :friendships
    has_many :friends, through: :friendships
    has_many :inverse_friendships, class_name: "Friendship", foreign_key: "friend_id"
    has_many :inverse_friends, through: :inverse_friendships, source: :user
    has_many :followships
    has_many :followings, through: :followships
    has_many :inverse_followships, class_name: "Followship", foreign_key: "following_id"
    has_many :followeds, through: :inverse_followships, source: :user
    mount_uploader :image, ImageUploader
    has_secure_password

    validates_uniqueness_of :email

    def self.from_omniauth(auth)
        where(email: auth.email).first_or_create do |user|
            user.firstname = auth.info.name
            user.email = auth.uid + "@twitter.com"
            user.remote_image_url = auth.info.image.sub("_normal", "")
            user.password_digest = auth.extra.access_token.token
            user.save
        end
    end

end
