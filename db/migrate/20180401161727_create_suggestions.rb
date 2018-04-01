class CreateSuggestions < ActiveRecord::Migration
  def change
    create_table :suggestions do |t|
      t.text :comment

      t.timestamps null: false
    end
  end
end
