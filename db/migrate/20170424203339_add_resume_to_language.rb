class AddResumeToLanguage < ActiveRecord::Migration
  def change
    add_reference :languages, :resume, index: true, foreign_key: true
  end
end
