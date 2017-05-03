class CreateCompanyInformations < ActiveRecord::Migration
  def change
    create_table :company_informations do |t|
      t.references :user, index: true, foreign_key: true
      t.string :contact_email
      t.string :address
      t.string :phone
      t.string :nit
      t.text :description

      t.timestamps null: false
    end
  end
end
