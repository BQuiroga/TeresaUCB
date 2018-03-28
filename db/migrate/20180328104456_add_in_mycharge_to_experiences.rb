class AddInMychargeToExperiences < ActiveRecord::Migration
  def change
    add_column :experiences, :in_my_charge, :integer
  end
end
