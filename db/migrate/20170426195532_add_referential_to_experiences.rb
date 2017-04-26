class AddReferentialToExperiences < ActiveRecord::Migration
  def change
    add_column :experiences, :referential, :string
  end
end
