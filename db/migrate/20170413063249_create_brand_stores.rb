class CreateBrandStores < ActiveRecord::Migration[5.0]
  def change
    create_table(:brand_stores) do |t|
      t.column(:shoe_store_id, :integer)
      t.column(:shoe_brand_id, :integer)

      t.timestamps()
    end
  end
end
