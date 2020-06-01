class AddLatLonToForests < ActiveRecord::Migration[6.0]
  def change
    add_column :forests, :latitude, :decimal
    add_column :forests, :longitude, :decimal
    add_index :forests, [:latitude, :longitude]
  end
end
