class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.text :description
      t.string :title
      t.integer :send
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
