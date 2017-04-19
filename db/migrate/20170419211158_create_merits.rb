class CreateMerits < ActiveRecord::Migration
  def change
    create_table :merits do |t|
      t.string :name
      t.date :date
      t.references :resume, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
