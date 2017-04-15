class ShoeStore < ActiveRecord::Base
  has_many :brand_stores
  has_many :shoe_brands, through: :brand_stores
end
