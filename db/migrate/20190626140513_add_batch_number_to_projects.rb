class AddBatchNumberToProjects < ActiveRecord::Migration[5.1]
  def change
    add_column :products, :batch_number, :integer
  end
end
