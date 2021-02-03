class Image < ActiveRecord::Base
    mount_uploader :file, ImageUpLoader
    belongs_to :imageable, polymorphic: true
end
