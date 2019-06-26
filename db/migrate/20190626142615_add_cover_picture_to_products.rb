class AddCoverPictureToProducts < ActiveRecord::Migration[5.1]
  def change
    add_column :products, :cover_picture, :string
  end
end
