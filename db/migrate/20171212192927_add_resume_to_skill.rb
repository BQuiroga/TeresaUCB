class AddResumeToSkill < ActiveRecord::Migration
  def change
    add_reference :skills, :resume, index: true, foreign_key: true
  end
end
