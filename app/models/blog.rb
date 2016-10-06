class Blog < ApplicationRecord
    after_initialize :set_defaults, unless: :persisted?
    belongs_to :user
    has_many :comments
    mount_uploader :image, ImageUploader
    default_scope { order("updated_at DESC")}

    acts_as_taggable

    def set_defaults
        self.nb_view  ||= 0
    end
end
