class AddDrawnItemsToForests < ActiveRecord::Migration[6.0]
  def change
    add_column :forests, :drawn_items, :jsonb
  end
end
