class AddResumeToExperience < ActiveRecord::Migration
  def change
    add_reference :experiences, :resume, index: true, foreign_key: true
  end
end
