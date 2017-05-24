class CreateSearcheds < ActiveRecord::Migration
  def change
    create_table :searcheds do |t|
      t.integer :searched_by
      t.integer :found

      t.timestamps null: false
    end
  end
end
