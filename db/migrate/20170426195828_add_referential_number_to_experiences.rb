class AddReferentialNumberToExperiences < ActiveRecord::Migration
  def change
    add_column :experiences, :referential_number, :string
  end
end
