class AddSalaryRangeToExperiences < ActiveRecord::Migration
  def change
    add_column :experiences, :salary_range, :string
  end
end
