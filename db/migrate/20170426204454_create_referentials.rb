class CreateReferentials < ActiveRecord::Migration
  def change
    create_table :referentials do |t|
      t.string :name
      t.string :number
      t.string :institution
      t.references :resume, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
