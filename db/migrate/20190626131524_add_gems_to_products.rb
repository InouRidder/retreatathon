class AddGemsToProducts < ActiveRecord::Migration[5.1]
  def change
    add_column :products, :gems, :text, array: true, default: []
  end
end
