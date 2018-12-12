class AddCivilToPersonalInformation < ActiveRecord::Migration
  def change
    add_column :personal_informations, :civil, :string
  end
end
