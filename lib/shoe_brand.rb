class ShoeBrand < ActiveRecord::Base
  has_many :brand_stores
  has_many :shoe_stores, through: :brand_stores
end
