class AddFieldsToPlants < ActiveRecord::Migration[6.0]
  def change
    remove_column :plants, :name
    add_column :plants, :scientific_name, :string
    add_column :plants, :trefle_data, :jsonb
  end
end
