class CreatePersonalInformations < ActiveRecord::Migration
  def change
    create_table :personal_informations do |t|
      t.string :address
      t.string :phone
      t.string :cellphone
      t.string :birthdate
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
