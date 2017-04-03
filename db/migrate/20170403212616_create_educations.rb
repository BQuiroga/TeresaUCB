class CreateEducations < ActiveRecord::Migration
  def change
    create_table :educations do |t|
      t.date :start_date
      t.date :end_date
      t.references :degree, index: true, foreign_key: true
      t.string :school_name
      t.string :title
      t.text :description

      t.timestamps null: false
    end
  end
end
