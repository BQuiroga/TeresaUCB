class CreateFriendships < ActiveRecord::Migration
  def change
    create_table :friendships do |t|
      t.integer :one
      t.integer :two

      t.timestamps null: false
    end
  end
end
