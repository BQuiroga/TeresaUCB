class AddUserToResume < ActiveRecord::Migration
  def change
    add_reference :resumes, :user, index: true, foreign_key: true
  end
end
