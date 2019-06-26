class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
      t.string :name
      t.text :customer_segment
      t.string :tagline
      t.text :pain
      t.text :solution
      t.text :user_core_journey
      t.text :originality
      t.string :github_repository_url

      t.timestamps
    end
  end
end
