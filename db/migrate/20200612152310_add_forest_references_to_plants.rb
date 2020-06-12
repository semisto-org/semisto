class AddForestReferencesToPlants < ActiveRecord::Migration[6.0]
  def change
    add_reference :plants, :forest, null: false, foreign_key: true
  end
end
