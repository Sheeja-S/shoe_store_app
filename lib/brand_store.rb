class BrandStore < ActiveRecord::Base
  belongs_to :shoe_brand
  belongs_to :shoe_store
end
