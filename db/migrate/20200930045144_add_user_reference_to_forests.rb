class AddUserReferenceToForests < ActiveRecord::Migration[6.0]
  def change
    add_reference :forests, :user, null: false, foreign_key: true
  end
end
