class AddResumeToCourses < ActiveRecord::Migration
  def change
    add_reference :courses, :resume, index: true, foreign_key: true
  end
end
