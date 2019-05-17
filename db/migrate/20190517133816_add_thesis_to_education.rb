class AddThesisToEducation < ActiveRecord::Migration
  def change
    add_column :educations, :thesis, :string
    add_column :educations, :grade, :integer
    add_column :educations, :average, :integer
    add_column :educations, :modality, :string
  end
end
