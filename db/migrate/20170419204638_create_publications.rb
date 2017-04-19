class CreatePublications < ActiveRecord::Migration
  def change
    create_table :publications do |t|
      t.string :name
      t.date :date
      t.string :location
      t.string :type
      t.references :resume, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
