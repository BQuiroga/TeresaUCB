class AddResumeToEducation < ActiveRecord::Migration
  def change
    add_reference :educations, :resume, index: true, foreign_key: true
  end
end
