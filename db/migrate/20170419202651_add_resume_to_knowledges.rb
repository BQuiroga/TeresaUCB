class AddResumeToKnowledges < ActiveRecord::Migration
  def change
    add_reference :knowlegdes, :resume, index: true, foreign_key: true
  end
end
