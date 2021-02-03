class Item < ActiveRecord::Base
    validates :price, numericality: { greater_than: 0, allow_nill: true }
    validates :name, :description, presence: true
    has_many :positions
    has_many :carts, through: :positions
    has_many :comments, as: :commentable
    has_one  :image, as: :imageable
    has_and_belongs_to_many :orders

    def image=(i)
        if !image || !new_record?
            @image = Image.create(i.merge({imageable: self}))
        end
    end

    # belongs_to :category

    # after_initialize { } #Item.new, Item.first
    # after_save       { } #Item.create, Item.save, Item.update_attributes()
    # after_create     { category.inc(:items_count, 1) } #Item.create
    # after_update     { } #Item.update_attributes(), Item.save
    # after_destroy    { category.inc(:items_count, -1) } #Item.destroy
end
