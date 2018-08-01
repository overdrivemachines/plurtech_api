class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.text :body
      t.boolean :has_image, default: false
      t.string :image_url
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
