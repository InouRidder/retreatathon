class AddBatchToProducts < ActiveRecord::Migration[5.1]
  def change
    add_column :products, :batch, :string
  end
end
