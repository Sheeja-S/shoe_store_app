require('sinatra')
require('sinatra/reloader')
require("sinatra/activerecord")
require('./lib/shoe_brand')
require('./lib/shoe_store')
require('./lib/brand_store')
also_reload('lib/**/*.rb')
require("pg")

get("/")do
  @shoe_brands = ShoeBrand.all()
  @shoe_stores = ShoeStore.all()
  erb(:index)
end

post('/') do
  name=params.fetch("name")
  @shoe_brand = ShoeBrand.new({:name => name})
  @shoe_brand.save()
  redirect to ('/')
end

get('/shoe_brand/:id/edit') do
  @shoe = ShoeBrand.find(params.fetch("id").to_i())
  erb(:shoe_brand_edit)
end

patch("/shoe_brand/:id") do
  name = params.fetch("name")
  @shoe = ShoeBrand.find(params.fetch("id").to_i())
  @shoe.update({:name => name})
  redirect to('/')
end

get("/shoe_brand_info/:id") do
   @shoe = ShoeBrand.find(params.fetch("id").to_i())
   @shoe_stores = ShoeStore.all()
   erb(:shoe_brand_info)
 end

 patch("/shoe_brand_info/:id") do
   shoe_brand_id = params.fetch("id").to_i()
   @shoe_brand = ShoeBrand.find(shoe_brand_id)

   shoe_store_ids = params.fetch("shoe_stores_ids")
   shoe_store_ids.each do |x|
     store = ShoeStore.find(x)
     BrandStore.create({:shoe_brand => @shoe_brand, :shoe_store => store })
   end
   @shoe_store = ShoeStore.all()
   redirect to("/shoe_brand_info/#{shoe_brand_id}")
 end

post('/shoe_stores') do
  name=params.fetch("name")
  @shoe_store = ShoeStore.new({:name => name})
  @shoe_store.save()
  redirect to ('/')
end

get('/shoe_store/:id/edit') do
  @shoe = ShoeStore.find(params.fetch("id").to_i())
  erb(:shoe_store_edit)
end

patch("/shoe_store/:id") do
  name = params.fetch("name")
  @shoe = ShoeStore.find(params.fetch("id").to_i())
  @shoe.update({:name => name})
  redirect to('/')
end

get('/shoe_store_info/:id') do
   @shoe = ShoeStore.find(params.fetch("id").to_i())
   @shoe_brands = ShoeBrand.all()
   erb(:shoe_store_info)
 end

 patch("/shoe_store_info/:id") do
   shoe_store_id = params.fetch("id").to_i()
   @shoe_store = ShoeStore.find(shoe_store_id)
   shoe_brand_ids = params.fetch("shoe_brands_ids")
   shoe_brand_ids.each do |x|
     brand = ShoeBrand.find(x)
     BrandStore.create({:shoe_brand => brand, :shoe_store => @shoe_store })
   end
   @shoe_brand = ShoeBrand.all()
   redirect to("/shoe_store_info/#{shoe_store_id}")
 end
