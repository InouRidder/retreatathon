class AddHostToProducts < ActiveRecord::Migration[5.1]
  def change
    add_column :products, :host, :string
  end
end
