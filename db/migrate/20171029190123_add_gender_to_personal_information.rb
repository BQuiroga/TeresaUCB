class AddGenderToPersonalInformation < ActiveRecord::Migration
  def change
    add_column :personal_informations, :gender, :boolean
  end
end
