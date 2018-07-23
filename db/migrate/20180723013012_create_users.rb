class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :username
      t.string :phone
      t.string :facebook
      t.string :snapchat
      t.string :twitter
      t.string :instagram
      t.datetime :last_online

      t.timestamps
    end
  end
end
