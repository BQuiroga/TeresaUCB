class CreateMemberships < ActiveRecord::Migration
  def change
    create_table :memberships do |t|
      t.string :name
      t.string :organization
      t.date :date
      t.references :resume, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
